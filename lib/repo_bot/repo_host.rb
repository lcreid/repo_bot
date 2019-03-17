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
      # TODO: put class name in here so user knows which repo is being accessed.
      @password ||= prompt_for_input("Enter password: ")
    end

    def repos
      connection = Faraday.new url do |conn|
        conn.adapter Faraday.default_adapter # make requests with Net::HTTP
        conn.basic_auth(username, password)
      end
      connection.get
    end

    def username
      # TODO: put class name in here so user knows which repo is being accessed.
      @username ||= prompt_for_input("Enter username: ")
    end

    private

    def prompt_for_input(prompt)
      print prompt
      gets.strip
    end
  end
end
