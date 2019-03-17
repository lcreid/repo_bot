# frozen_string_literal: true

module RepoBot
  class BitbucketHost < RepoHost
    def initialize(username: nil, password: nil)
      super("https://api.bitbucket.org/2.0/repositories",
        username: username || ENV["BITBUCKET_USERNAME"],
        password: password || ENV["BITBUCKET_PASSWORD"])
    end
  end
end
