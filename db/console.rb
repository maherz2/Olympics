require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/event')
require_relative('../models/nation')
require_relative('../models/sport')
require_relative('../models/team')

Athlete.delete_all()
Team.delete_all()
Event.delete_all()
Sport.delete_all()
Nation.delete_all()

france = Nation.new({'name' => 'France', 'flag_url' => 'www.google.com/images/french_flag.jpg', 'population' => '66000000'}).save
uk = Nation.new({'name' => 'UK', 'flag_url' => 'www.google.com/images/uk_flag.jpg', 'population' => '75000000'}).save

athlete1 = Athlete.new({'name' => 'Joe Maher', 'dob' => "1988-10-01", 'sex' => 'male', 'height' => '175', 'weight' => '96', 'nation_id' => france.id}).save
athlete2 = Athlete.new({'name' => 'Rachel Barry', 'dob' => "1990-02-21", 'sex' => 'female', 'height' => '150', 'weight' => '60', 'nation_id' => uk.id }).save

rowing = Sport.new({'id' => '1', 'name' => 'Rowing', 'type' => 'Water'}).save

event = Event.new({'id' => '1', 'name' => '100m sprint', 'participation_type' => 'single', 'max_capacity' => '10', 'world_record' => '9.2', 'sport_id' => rowing.id}).save

team = Team.new({'id' => '1', 'nation_id' => france.id}).save





binding.pry
nil