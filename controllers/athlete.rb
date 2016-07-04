require('sinatra')
require('sinatra/contrib/all')

get '/athlete/index' do
@athletes = Athlete.search(params['search']) if params['search']
erb(:'/athlete/index')
end

get '/athlete/new' do
@nations = Nation.all()
erb(:'/athlete/new')
end

post '/athlete/new' do
params['dob'] = "#{params['year']}-#{params['month']}-#{params['day']}"
athlete = Athlete.new(params).save()
redirect to(:"/athlete/#{athlete.id}")
end

get '/athlete/:id/edit' do
@nations = Nation.all()
@athlete = Athlete.find(params[:id])
erb(:"/athlete/edit")
end

post '/athlete/:id/edit' do
athlete = Athlete.find(params[:id])
athlete.update(params)
redirect to(:"/athlete/#{athlete.id}")
end

post '/athlete/:id/delete' do
athlete = Athlete.find(params[:id])
athlete.delete()
redirect to(:"/settings")
end

#must go last
get '/athlete/:id' do
@athlete = Athlete.find(params[:id])
erb(:'/athlete/view')
end