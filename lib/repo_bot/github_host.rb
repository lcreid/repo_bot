# frozen_string_literal: true

module RepoBot
  class GithubHost < RepoHost
    def initialize(username: nil, password: nil)
      @api_url = "https://api.github.com"
      super(username: username || ENV["GITHUB_USERNAME"],
            password: password || ENV["GITHUB_PASSWORD"])
    end

    def organization_repositories
      user_organizations.flat_map do |org|
        Response.new(request("/orgs/#{org}/repos")).to_json
      end
    end

    # Get the user's repositories, and all the repositories of organizations
    # to which the user belongs.
    def repos
      organization_repositories + user_repositories
    end

    def user_organizations
      response = request("/user/orgs")
      JSON.parse(response.body).map { |org| org["login"] }
    end

    def user_repositories
      Response.new(request("/user/repos")).to_json
    end

    class Response < RepoBot::Response
      def to_json
        JSON.parse(body).map { |repo| repo.slice("full_name", "private", "fork", "created_at", "pushed_at") }
      end
    end
  end
end
