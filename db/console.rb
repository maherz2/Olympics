require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/event')
require_relative('../models/nation')
require_relative('../models/sport')
require_relative('../models/team')
require_relative('sql_runner')


run("DELETE FROM team_members")
run("DELETE FROM athlete_results")
run("DELETE FROM team_results")
Event.delete_all()
Team.delete_all()
Sport.delete_all()
Athlete.delete_all()
Nation.delete_all()

#add nations
france = Nation.new({'name' => 'France', 'flag_url' => 'www.google.com/images/french_flag.jpg', 'population' => '66000000'}).save
uk = Nation.new({'name' => 'UK', 'flag_url' => 'www.google.com/images/uk_flag.jpg', 'population' => '75000000'}).save

#add athletes
athlete1 = Athlete.new({'name' => 'Joe Maher', 'dob' => "1988-10-01", 'sex' => 'male', 'height' => '175', 'weight' => '96', 'nation_id' => france.id}).save
athlete2 = Athlete.new({'name' => 'Rachel Barry', 'dob' => "1990-02-21", 'sex' => 'female', 'height' => '150', 'weight' => '60', 'nation_id' => uk.id }).save

#add sports
rowing = Sport.new({'name' => 'Rowing', 'type' => 'Water'}).save
cycling = Sport.new({'name' => 'Cycling', 'type' => 'Track'}).save
diving = Sport.new({'name' => 'Diving', 'type' => 'Water'}).save

#add teams
team = Team.new({'id' => '1', 'nation_id' => france.id}).save
  #add team methods
  team.add_athlete(athlete1)
  #team.add_athlete(athlete2)
  team.athletes

#add events
event = Event.new({'name' => '3000m', 'participation_type' => 'athlete', 'max_capacity' => '10', 'world_record' => '9.2', 'sport_id' => rowing.id}).save
event1 = Event.new({'name' => '300m sprint', 'participation_type' => 'athlete', 'max_capacity' => '10', 'world_record' => '9.2', 'sport_id' => cycling.id}).save
event2 = Event.new({'name' => 'High Dive', 'participation_type' => 'athlete', 'max_capacity' => '7', 'world_record' => '9.2', 'sport_id' => diving.id}).save
event3 = Event.new({'name' => 'Low Dive', 'participation_type' => 'team', 'max_capacity' => '7', 'world_record' => '9.2', 'sport_id' => diving.id}).save
  
  #event methods
  event.add_result({'participant' => athlete1, 'measure' => '3minutes 2 seconds', 'position' => 1})
  event.add_result({'participant' => athlete2, 'measure' => '5minutes 18 seconds', 'position' => 2})
  event1.add_result({'participant' => athlete1, 'measure' => '4minutes 18 seconds', 'position' => 1})
  event2.add_result({'participant' => athlete1, 'measure' => '4minutes 18 seconds', 'position' => 1})
  event3.add_result({'participant' => team, 'measure' => '4minutes 18 seconds', 'position' => 1})
  event1.sport
  event.athletes

  #sport methods
  rowing.athletes
  rowing.teams
  rowing.nations
  france.update({'name' => "Germany"})






binding.pry
nil