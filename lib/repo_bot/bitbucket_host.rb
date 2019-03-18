# frozen_string_literal: true

module RepoBot
  class BitbucketHost < RepoHost
    def initialize(username: nil, password: nil)
      @api_url = "https://api.bitbucket.org/2.0"
      super(username: username || ENV["BITBUCKET_USERNAME"],
            password: password || ENV["BITBUCKET_PASSWORD"])
    end

    def repos
      Response.new(request("/repositories/?role=contributor")).to_json
    end

    class Response < RepoBot::Response
      def to_json
        JSON.parse(body)["values"].map { |repo| repo.slice("full_name", "is_private", "created_on", "updated_on") }
      end
    end
  end
end
