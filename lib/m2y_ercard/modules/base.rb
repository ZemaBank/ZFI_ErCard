module M2yErcard
  class Base
    def self.base_url
      M2yErcard.configuration.server_url
    end

    def self.base_headers
      headers = {}
      headers['Content-Type'] = "application/json"
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
      post_encoded(base_url + TOKEN_PATH, body).parsed_response["access_token"]
    end

    def self.post_encoded(url, body)
      headers = {}
      headers['Content-Type'] = "application/x-www-form-urlencoded"
      headers['charset'] = "utf-8"
      puts "Sending POST request to URL: #{url}"
      HTTParty.post(url, headers: headers, body: URI.encode_www_form(body))
    end

    def self.post(url, body, headers = nil)
      headers = base_headers if headers.nil?
      puts "Sending POST request to URL: #{url}"
      if M2yErcard.configuration.production?
        HTTParty.post(url, headers: headers, body: body.to_json)
      else
        HTTParty.post(url, headers: headers, body: body.to_json, debug_output: $stdout)
      end
    end
  end
end
