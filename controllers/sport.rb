require('sinatra')
require('sinatra/contrib/all')

get '/sport/index' do
@sports = Sport.search(params['search']) if params['search']
erb(:'/sport/index')
end

get '/sport/new' do
erb(:'/sport/new')
end

post '/sport/new' do
sport = Sport.new(params).save()
redirect to(:"/sport/#{sport.id}")
end

get '/sport/:id/edit' do
@sport = Sport.find(params[:id])
erb(:"/sport/edit")
end

post '/sport/:id/edit' do
sport = Sport.find(params[:id])
sport.update(params)
redirect to(:"/sport/#{sport.id}")
end

post '/sport/:id/delete' do
sport = Sport.find(params[:id])
sport.delete()
redirect to(:"/settings")
end


#must go last
get '/sport/:id' do
@sport = Sport.find(params[:id])
erb(:'/sport/view')
end