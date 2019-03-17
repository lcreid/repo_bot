# frozen_string_literal: true

require "repo_bot/repo_host"
require "repo_bot/bitbucket_host"
require "repo_bot/github_host"
require "repo_bot/version"
require "repo_bot/response"
require "faraday"

module RepoBot
  class Error < StandardError; end
  # Your code goes here...
  class << self
    def bitbucket_repos
      BitbucketHost.new.repos
    end

    def git_repos
      GithubHost.new.repos
    end
  end
end
