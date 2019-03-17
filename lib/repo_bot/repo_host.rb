module RepoBot
  class RepoHost
    def initialize(url, username: nil, password: nil)
      @url = url
      @username = username
      @password = password
    end

    attr_reader :password, :url, :username
  end
end
