# frozen_string_literal: true

module RepoBot
  class RepoHost
    def initialize(url = nil, username: nil, password: nil)
      @username = username
      @password = password
    end

    attr_reader :url

    def password
      @password ||= prompt_for_input("Enter #{humanize(self.class)} password: ")
    end

    def request(path, page = nil, limit = nil)
      connection = Faraday.new construct_url(path, page, limit) do |conn|
        conn.adapter Faraday.default_adapter # make requests with Net::HTTP
        conn.basic_auth(username, password)
      end
      response = connection.get
      raise RepoBot::Error("Request failed (#{response.status})") unless response.status == 200

      response
    end

    def username
      @username ||= prompt_for_input("Enter #{humanize(self.class)} username: ")
    end

    private

    def humanize(klass)
      klass.to_s.gsub(/RepoBot::(.+)Host/, '\1')
    end

    def next_character(url_so_far)
      url_so_far.index("?").nil? ? "?" : "&"
    end

    def prompt_for_input(prompt)
      print prompt
      gets.strip
    end
  end
end
