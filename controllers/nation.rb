require('sinatra')
require('sinatra/contrib/all')

get '/nation/index' do
@nations = Nation.search(params['search']) if params['search']
erb(:'/nation/index')
end

get '/nation/new' do
erb(:'/nation/new')
end

post '/nation/new' do
nation = Nation.new(params).save()
redirect to(:"/nation/#{nation.id}")
end

get '/nation/:id/edit' do
@nation = Nation.find(params[:id])
erb(:"/nation/edit")
end

post '/nation/:id/edit' do
nation = Nation.find(params[:id])
nation.update(params)
redirect to(:"/nation/#{nation.id}")
end

post '/nation/:id/delete' do
nation = Nation.find(params[:id])
nation.delete()
redirect to(:"/settings")
end

#must go last
get '/nation/:id' do
@nation = Nation.find(params[:id])
erb(:'/nation/view')
end