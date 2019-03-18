# frozen_string_literal: true

module RepoBot
  class BitbucketHost < RepoHost
    def initialize(username: nil, password: nil)
      @api_url = "https://api.bitbucket.org/2.0"
      super(username: username || ENV["BITBUCKET_USERNAME"],
            password: password || ENV["BITBUCKET_PASSWORD"])
    end

    def repos
      repositories = []
      url = @api_url + "/repositories/?role=contributor"
      loop do
        response = Response.new(request(url))
        repositories += response.repository_data
        url = to_json["next"]
        break if url.nil?
      end
      repositories
    end

    class Response < RepoBot::Response
      def repository_data
        to_json["values"].map { |repo| repo.slice("full_name", "is_private", "created_on", "updated_on") }
      end

      def to_json
        @to_json ||= JSON.parse(body) if status == 200
      end
    end
  end
end
