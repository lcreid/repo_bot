# frozen_string_literal: true

module RepoBot
  class GithubHost < RepoHost
    def initialize(username: nil, password: nil)
      super("https://api.github.com/user/repos",
        username: username || ENV["GITHUB_USERNAME"],
        password: password || ENV["GITHUB_PASSWORD"])
    end

    def repos
      Response.new(super)
    end

    class Response < RepoBot::Response
      def to_json
        JSON.parse(body).map { |repo| repo.slice("full_name", "private", "fork", "created_at", "pushed_at") }
      end
    end
  end
end
