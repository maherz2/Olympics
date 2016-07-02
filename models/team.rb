class Team

attr_reader(:id, :nation_id)
  
  def initialize(options)
    @id = options['id'].to_i
    @nation_id = options['nation_id'].to_i
  end

  def update(options)
    @nation_id = options['nation_id'] if options['nation_id'] && nation_exists?(options['nation_id'])
    sql = "UPDATE teams SET nation_id = '#{options['nation_id']}' WHERE id = '#{@id}'"
    run(sql) if nation_exists?(options['nation_id'])
  end

  def nation_exists?(nation_id)
    nations = Nation.all()
    nations.each {|nation| return true if nation.id == nation_id }
    return false
  end

  def save()
    sql = "INSERT INTO teams (name, nation_id) 
    VALUES ('#{@name}', '#{@nation_id}') RETURNING *"
    team= run(sql).first
    result = Team.new(team)
    return result
  end

  def delete()
    sql = "DELETE FROM teams WHERE id = '#{@id}'"
    run(sql)
  end

  def add_athlete(athlete)
    sql = "INSERT INTO team_members (athlete_id, team_id) VALUES ('#{athlete.id}', '#{@id}')"
    run(sql)
  end

  def athletes()
    sql = "SELECT athletes.* FROM athletes INNER JOIN team_members ON athletes.id = team_members.athlete_id WHERE team_members.team_id = #{@id}"
    return Athlete.map_items(sql)
  end

  def self.all()
    sql = "SELECT * FROM teams"
    return Team.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM teams"
    run(sql)
  end

  def self.map_items(sql)
    teams = run(sql)
    result = teams.map { |team| Team.new(team) }
    return result
  end

  def self.map_item(sql)
    result = map_items(sql)
    return result.first
  end

end