require('minitest/autorun')
require_relative('../models/nation')

class NationTest < MiniTest::Test

  def setup()
    options = {'id' => '1', 'name' => 'France', 'flag_url' => 'www.google.com/images/french_flag.jpg', 'population' => '66000000'}
    @nation1 = Nation.new(options)
  end

  def test_nation_name()
    assert_equal('France', @nation1.name )
  end

  def test_nation_id()
    assert_equal(1, @nation1.id )
  end

  def test_nation_population()
    assert_equal(66000000, @nation1.population )
  end

  def test_nation_flag_url()
    assert_equal('www.google.com/images/french_flag.jpg', @nation1.flag_url )
  end

end