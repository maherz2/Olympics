require('minitest/autorun')
require_relative('../models/team')

class TeamTest < MiniTest::Test

  def setup()
    options = {'id' => '1', 'nation_id' => '3'}
    @team = Team.new(options)
  end

  def test_team_id()
    assert_equal(1, @team.id )
  end

  def test_team_type()
    assert_equal(3, @team.nation_id)
  end

end