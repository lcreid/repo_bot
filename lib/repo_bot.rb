# frozen_string_literal: true

require "repo_bot/version"
require "repo_bot/response"
require "faraday"

module RepoBot
  class Error < StandardError; end
  # Your code goes here...
  class << self
    def git_repos
      connection = Faraday.new "https://api.github.com/user/repos" do |conn|
        conn.adapter Faraday.default_adapter # make requests with Net::HTTP
        conn.basic_auth(RepoBot.git_username, RepoBot.git_password)
      end
      RepoBot::Response.new(connection.get)
    end

    def git_password
      @git_password ||= prompt_for_input("Enter git password: ")
    end

    attr_writer :git_password

    def git_username
      @git_username ||= prompt_for_input("Enter git username: ")
    end

    attr_writer :git_username

    private

    def prompt_for_input(prompt)
      print prompt
      gets.strip
    end
  end
end
