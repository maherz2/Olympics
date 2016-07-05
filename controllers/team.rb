require('sinatra')
require('sinatra/contrib/all')

get '/team/index' do
@teams = Team.search(params['search']) if params['search']
erb(:'/team/index')
end

get '/team/new' do
# binding.pry
@nations = Nation.all()
erb(:'/team/new')
end

post '/team/new' do
team = Team.new(params).save()
redirect to(:"/team/#{team.id}/add_members")
end

get '/team/:id/edit' do
@team = Team.find(params[:id])
erb(:"/team/edit")
end

post '/team/:id/edit' do
team = Team.find(params[:id])
team.update(params)
redirect to(:"/team/#{team.id}")
end

post '/team/:id/delete' do
team = Team.find(params[:id])
team.delete()
redirect to(:"/settings")
end

post '/team/:id/add_members' do
  @team = Team.find(params['id'].to_i)
  params['athletes'].each do |athlete_id|
    athlete = Athlete.find(athlete_id.to_i)
    # binding.pry
    @team.add_athlete(athlete)
  end
  @team_athletes = @team.athletes
  erb(:"/team/view")
end

get '/team/:id/add_members' do
@team = Team.find(params[:id])
@athletes = Athlete.all()
@teams = Team.all()
@nations = Nation.all()
erb(:'/team/add_members')
end


#must go last
get '/team/:id' do
@team = Team.find(params[:id])
erb(:'/team/view')
end