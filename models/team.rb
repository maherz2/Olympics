class Team

attr_reader(:id, :nation_id)
  
  def initialize(options)
    @id = options['id'].to_i
    @nation_id = options['nation_id'].to_i
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

  def update(options)
    sql = "UPDATE teams SET nation_id = '#{options['nation_id']} WHERE id = '#{@id}'"
    run(sql)
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