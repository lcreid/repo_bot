# frozen_string_literal: true

module RepoBot
  class GithubHost < RepoHost
    def initialize(username: nil, password: nil)
      @api_url = "https://api.github.com"
      super(username: username || ENV["GITHUB_USERNAME"],
            password: password || ENV["GITHUB_PASSWORD"])
    end

    # Get the user's repositories, and all the repositories of organizations
    # to which the user belongs.
    # TODO: Use GitHub's Ruby library:
    # https://developer.github.com/v3/guides/traversing-with-pagination/#consuming-the-information
    def repos
      repositories = []
      page = 1
      limit = 100 # Maximum allowed by GitHub
      loop do
        response = Response.new(request("/user/repos", page, limit))
        break if response.to_json.empty?

        repositories += response.to_json
        page += 1
      end
      repositories
    end

    private

    def construct_url(path, page, limit)
      url = @api_url + path
      url += next_character(url) + "page=#{page}" if page
      url += next_character(url) + "per_page=#{limit}" if limit
      url
    end

    class Response < RepoBot::Response
      def to_json
        JSON.parse(body).map { |repo| repo.slice("full_name", "private", "fork", "created_at", "pushed_at") }
      end
    end
  end
end
