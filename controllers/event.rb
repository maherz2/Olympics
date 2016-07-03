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

#must go last
get '/event/:id' do
@event = Event.find(params[:id])
erb(:'/event/view')
end