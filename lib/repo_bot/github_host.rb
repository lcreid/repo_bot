# frozen_string_literal: true

require "octokit"

module RepoBot
  class GithubHost < RepoHost
    def initialize(username: nil, password: nil)
      @api_url = "https://api.github.com"
      super(username: username || ENV["GITHUB_USERNAME"],
            password: password || ENV["GITHUB_PASSWORD"])
      @client = Octokit::Client.new(login: self.username, password: self.password)
    end
    attr_reader :client

    # Get the user's repositories, and all the repositories of organizations
    # to which the user belongs.
    # https://developer.github.com/v3/guides/traversing-with-pagination/#consuming-the-information
    def repos
      repositories = repository_data(client.repos)
      last_response = client.last_response
      until last_response.rels[:next].nil?
        last_response = last_response.rels[:next].get
        repositories += repository_data(last_response.data)
      end
      repositories
    end

    private

    def repository_data(data)
      data.map do |repo|
        repo.to_hash.slice(:full_name, :private, :fork, :created_at, :pushed_at)
      end
    end
  end
end
