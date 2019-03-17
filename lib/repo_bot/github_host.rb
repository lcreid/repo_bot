# frozen_string_literal: true

module RepoBot
  class GithubHost < RepoHost
    def initialize(username: nil, password: nil)
      super("https://api.github.com/user/repos", username: username, password: password)
    end

    def password
      @password ||= prompt_for_input("Enter git password: ")
    end

    def username
      @username ||= prompt_for_input("Enter git username: ")
    end

    private

    def prompt_for_input(prompt)
      print prompt
      gets.strip
    end
  end
end
