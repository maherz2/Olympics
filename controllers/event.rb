require('sinatra')
require('sinatra/contrib/all')

get '/event/index' do
@events = Event.search(params['search']) if params['search']
erb(:'/event/index')
end

get '/event/new' do
@sports = Sport.all()
erb(:'/event/new')
end

post '/event/new' do
event = Event.new(params).save()
redirect to(:"/event/#{event.id}")
end

get '/event/:id/edit' do
@sports = Sport.all()
@event = Event.find(params[:id])
erb(:"/event/edit")
end

post '/event/:id/edit' do
event = Event.find(params[:id])
event.update(params)
redirect to(:"/event/#{event.id}")
end

get "/event/:id/add_result" do
@event = Event.find(params['id'])
@nation = Nation.all()
@athletes = Athlete.all
@teams = Team.all()
erb(:'/event/add_results')
end

post '/event/:id/add_results' do
  event = Event.find(params[:id])
  event.mass_add_results(params)
  redirect to(:"/event/#{event.id}")
end

#must go last
get '/event/:id' do
@event = Event.find(params[:id])
erb(:'/event/view')
end