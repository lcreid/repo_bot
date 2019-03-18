# frozen_string_literal: true

module RepoBot
  class RepoHost
    def initialize(url, username: nil, password: nil)
      @username = username
      @password = password
      @url = url.respond_to?(:call) ? url.call : url
    end

    attr_reader :url

    def password
      @password ||= prompt_for_input("Enter #{humanize(self.class)} password: ")
    end

    def repos
      connection = Faraday.new url do |conn|
        conn.adapter Faraday.default_adapter # make requests with Net::HTTP
        conn.basic_auth(username, password)
      end
      connection.get
    end

    def username
      @username ||= prompt_for_input("Enter #{humanize(self.class)} username: ")
    end

    private

    def humanize(klass)
      klass.to_s.gsub(/RepoBot::(.+)Host/, '\1')
    end

    def prompt_for_input(prompt)
      print prompt
      gets.strip
    end
  end
end
