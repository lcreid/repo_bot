# frozen_string_literal: true

require "json"

module RepoBot
  class Response
    def initialize(http_response)
      @http_response = http_response
    end

    attr_reader :http_response

    def body
      # https://github.com/lostisland/faraday/issues/139
      http_response.body.force_encoding("utf-8")
    end

    def method_missing(symbol, *args)
      http_response.send(symbol, *args)
    end

    def respond_to_missing?(_method_name, _include_private = false)
      true
    end
  end
end
