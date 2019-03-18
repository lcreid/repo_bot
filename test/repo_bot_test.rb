# frozen_string_literal: true

require "test_helper"

class RepoBotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RepoBot::VERSION
  end

  def test_query_bitbucket
    response = RepoBot.bitbucket_repos
    pp response
  end

  def test_query_github
    response = RepoBot.github_repos
    pp response
  end
end
