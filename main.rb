require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/athlete')
require_relative('./models/event')
require_relative('./models/nation')
require_relative('./models/sport')
require_relative('./models/team')
require_relative('./controllers/athlete')
require_relative('./controllers/event')
require_relative('./controllers/nation')
require_relative('./controllers/sport')
require_relative('./controllers/team')

get '/' do
erb(:home)
end