require "test_helper"

class RepoBotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RepoBot::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
