# frozen_string_literal: true

require "repo_bot/repo_host"
require "repo_bot/github_host"
require "repo_bot/version"
require "repo_bot/response"
require "faraday"

module RepoBot
  class Error < StandardError; end
  # Your code goes here...
  class << self
    def bitbucket_repos
      
    end

    def git_repos
      repos(GithubHost.new)
    end

    private

    def repos(repo_host)
      connection = Faraday.new repo_host.url do |conn|
        conn.adapter Faraday.default_adapter # make requests with Net::HTTP
        conn.basic_auth(repo_host.username, repo_host.password)
      end
      RepoBot::Response.new(connection.get)
    end
  end
end
