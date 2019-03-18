# frozen_string_literal: true

module RepoBot
  class BitbucketHost < RepoHost
    def initialize(username: nil, password: nil)
      @api_url = "https://api.bitbucket.org/2.0"
      super(username: username || ENV["BITBUCKET_USERNAME"],
            password: password || ENV["BITBUCKET_PASSWORD"])
    end

    # TODO: Should use the next links from the response.
    def repos
      repositories = []
      page = 1
      limit = 100 # Maximum allowed by GitHub
      loop do
        response = Response.new(request("/repositories/?role=contributor", page, limit))
        repositories += response.to_json
        break if JSON.parse(response.body)["next"].nil?

        page += 1
      end
      repositories
    end

    private

    def construct_url(path, page, limit)
      url = @api_url + path
      url += next_character(url) + "page=#{page}" if page
      url += next_character(url) + "pagelen=#{limit}" if limit
      url
    end

    class Response < RepoBot::Response
      def to_json
        JSON.parse(body)["values"].map { |repo| repo.slice("full_name", "is_private", "created_on", "updated_on") }
      end
    end
  end
end
