# frozen_string_literal: true

require "test_helper"

class RepoBotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RepoBot::VERSION
  end

  def test_query_bitbucket
    response = RepoBot.bitbucket_repos
    pp response.to_json
    assert_equal 200, response.status
  end

  def test_query_github
    response = RepoBot.git_repos
    pp response.to_json
    assert_equal 200, response.status
  end
end
