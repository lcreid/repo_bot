# frozen_string_literal: true

module RepoBot
  class GithubHost < RepoHost
    def initialize(username: nil, password: nil)
      super("https://api.github.com/user/repos",
        username: username || ENV["GITHUB_USERNAME"],
        password: password || ENV["GITHUB_PASSWORD"])
    end
  end
end
