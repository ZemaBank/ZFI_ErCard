module M2yErcard
  class Base
    def self.base_url
      M2yErcard.configuration.server_url
    end

    def self.base_headers
      headers = {}
      headers['Content-Type'] = 'application/json'
      headers['Authorization'] = "Bearer #{get_token}"
      headers
    end

    def self.get_token
      body = {
        grant_type: 'password',
        username: M2yErcard.configuration.username,
        password: M2yErcard.configuration.password,
        strEmpresa: COMPANY_CODE
      }
      post_encoded(base_url + TOKEN_PATH, body).parsed_response['access_token']
    end

    def self.post_encoded(url, body)
      headers = {}
      headers['Content-Type'] = 'application/x-www-form-urlencoded'
      headers['charset'] = 'utf-8'
      # puts "Sending POST request to URL: #{url}"
      HTTParty.post(url, headers: headers, body: URI.encode_www_form(body))
    end

    def self.post(url, body, headers = nil)
      headers = base_headers if headers.nil?
      # puts "Sending POST request to URL: #{url}"
      if M2yErcard.configuration.production?
        format_response(HTTParty.post(url, headers: headers, body: body.to_json))
      else
        format_response(HTTParty.post(url, headers: headers, body: body.to_json, debug_output: $stdout))
      end
    end

    def self.get(url, headers = nil, query: nil)
      headers = base_headers if headers.nil?
      # puts "Sending GET request to URL: #{url}"
      if M2yErcard.configuration.production?
        format_response(HTTParty.get(url, headers: headers, query: query))
      else
        format_response(HTTParty.get(url, headers: headers, query: query, debug_output: $stdout))
      end
    end

    def self.format_response(original_response)
      response = original_response.parsed_response
      response = { body: response } if response.is_a?(Array)
      response = {} unless response.is_a?(Hash) # Could be empty
      response = response.deep_symbolize_keys!
      response[:status_code] = original_response.code

      begin
        response[:original_request] = original_response.request.raw_body
        response[:url] = original_response.request.uri
      rescue StandardError
        response[:original_request] = nil
        response[:url] = nil
      end

      if response[:status_code] == 401
        response[:message] = response.dig(:error, :Message) || 'Sessão expirada'
      else
        response[:message] = response[:strMensagem] if response[:strMensagem].present?
      end
      # puts response
      response
    end

    # Environment constants
    def self.product_code
      M2yErcard.configuration.production? ? PRODUCT_CODE_PRD : PRODUCT_CODE_HMG
    end
  end
end
