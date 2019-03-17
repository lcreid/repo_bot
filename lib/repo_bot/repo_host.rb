# frozen_string_literal: true

module RepoBot
  class RepoHost
    def initialize(url, username: nil, password: nil)
      @url = url
      @username = username
      @password = password
    end

    attr_reader :url

    def password
      @password ||= prompt_for_input("Enter password: ")
    end

    def repos
      connection = Faraday.new url do |conn|
        conn.adapter Faraday.default_adapter # make requests with Net::HTTP
        conn.basic_auth(username, password)
      end
      RepoBot::Response.new(connection.get)
    end

    def username
      @username ||= prompt_for_input("Enter username: ")
    end

    private

    def prompt_for_input(prompt)
      print prompt
      gets.strip
    end
  end
end
