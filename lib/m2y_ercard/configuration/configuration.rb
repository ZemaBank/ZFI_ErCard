# frozen_string_literal: true

module M2yErcard
  class Configuration

    attr_writer :username, :password, :server_url, :env

    def initialize #:nodoc:
      @username = nil
      @password = nil
      @server_url = nil
      @env = nil
    end

    def username
      @username
    end

    def password
      @password
    end

    def server_url
      @server_url
    end

    def env
      @env
    end

    def production?
      env.to_s.upcase == 'PRD'
    end
  end
end
