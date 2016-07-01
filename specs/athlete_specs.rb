require('minitest/autorun')
require('date')
require_relative('../models/athlete')

class AthleteTest < MiniTest::Test

  def setup()
    options = {'id' => '1', 'name' => 'Boris Johnson', 'dob' => "1988-10-01", 'sex' => 'male', 'height' => '175', 'weight' => '96', 'nation_id' => '3'}
    @boris_johnson = Athlete.new(options)
  end

  def test_athlete_name()
    assert_equal('France', @boris_johnson.name )
  end

  def test_athlete_id()
    assert_equal(1, @boris_johnson.id )
  end

  def test_athlete_name()
    assert_equal("Boris Johnson", @boris_johnson.name )
  end

  def test_athlete_dob()
    assert_equal("1988-10-01", @boris_johnson.dob)
  end

  def test_athlete_sex()
    assert_equal("male", @boris_johnson.sex )
  end

  def test_athlete_height()
    assert_equal(175, @boris_johnson.height)
  end

  def test_athlete_weight()
    assert_equal(96, @boris_johnson.weight)
  end

  def test_athlete_nation_id()
    assert_equal(3, @boris_johnson.nation_id)
  end

  def test_athlete_age()
    assert_equal(28, @boris_johnson.age)
  end


end