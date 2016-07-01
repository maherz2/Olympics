require('minitest/autorun')
require_relative('../models/event')

class EventTest < MiniTest::Test

  def setup()
    options = {'id' => '1', 'name' => '100m sprint', 'participation_type' => 'single', 'max_capacity' => '10', 'world_record' => '9.2', 'sport_id' => '3'}
    @event = Event.new(options)
  end

  def test_event_name()
    assert_equal('100m sprint', @event.name )
  end

  def test_event_id()
    assert_equal(1, @event.id )
  end

  def test_event_type()
    assert_equal('single', @event.participation_type )
  end

  def test_event_max_cap()
    assert_equal(10, @event.max_capacity )
  end

  def test_event_id()
    assert_equal('9.2', @event.world_record )
  end

  def test_event_id()
    assert_equal(3, @event.sport_id )
  end

end