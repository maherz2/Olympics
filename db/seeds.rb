require ('randomperson')
require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/event')
require_relative('../models/nation')
require_relative('../models/sport')
require_relative('../models/team')
require_relative('sql_runner')

r = RandomPerson()
params = {}

######genrates random athletes
# nations = Nation.all()
# nations.each do |nation|
#   rand(25..45).times do
#   person = r.generate()
#   params['name'] = "#{person.first} #{person.last}"
#   params['dob'] = person.dob
#   if person.gender = "m"
#     params['sex'] = "male"
#   else
#     params['sex'] = "female"
#   end
#   params['height'] = rand(150..200)
#   params['weight'] = rand(60..120)
#   params['nation_id'] = nation.id
#   athlete = Athlete.new(params).save
#   end
# end

events = Event.all()

events.each do |event|

  if event.participation_type == "athlete"

  else







end






binding.pry
nil