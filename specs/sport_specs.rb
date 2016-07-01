require('minitest/autorun')
require_relative('../models/sport')

class SportTest < MiniTest::Test

  def setup()
    options = {'id' => '1', 'name' => 'Rowing', 'type' => 'Water'}
    @rowing = Sport.new(options)
  end

  def test_sport_name()
    assert_equal('Rowing', @rowing.name )
  end

  def test_sport_id()
    assert_equal(1, @rowing.id )
  end

  def test_sport_type()
    assert_equal('Water', @rowing.type )
  end

end