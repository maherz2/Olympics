class Sport

attr_reader(:id, :name, :type)
  
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @type = options['type']
  end

  def save()
    sql = "INSERT INTO sports (name, type) 
    VALUES ('#{@name}', '#{@type}') RETURNING *"
    sport = run(sql).first
    result = Sport.new(sport)
    return result
  end

  def delete()
    sql = "DELETE FROM sports WHERE id = '#{@id}'"
    run(sql)
  end

  def update(options)
    sql = "UPDATE sport SET name = '#{options['name']}', 
    type = '#{options['type']}'
    WHERE id = '#{@id}'"
    run(sql)
  end

  def events()
    sql = "SELECT * FROM events WHERE sport_id = #{@id}"
    return Event.map_items(sql)
  end

  def athletes()
    sql = "SELECT athletes.* FROM athletes 
    INNER JOIN athlete_results ON athlete_results.athlete_id = athletes.id 
    INNER JOIN events ON events.id = athlete_results.event_id WHERE events.sport_id = #{@id}"
    return Athlete.map_items(sql)
  end

  def teams()
    sql = "SELECT teams.* FROM teams 
    INNER JOIN team_results ON team_results.team_id = teams.id 
    INNER JOIN events ON events.id = team_results.event_id WHERE events.sport_id = #{@id}"
    return Team.map_items(sql)
  end

  def nations()
    sql = "SELECT nations.* FROM nations 
    INNER JOIN athletes ON nations.id = athletes.nation_id
    INNER JOIN athlete_results ON athlete_results.athlete_id = athlete_id
    INNER JOIN events ON events.id = athlete_results.event_id WHERE events.sport_id = #{@id}"
    nations = Nation.map_items(sql).uniq
    return nations.uniq { |nation| nation.id } 
  end

  def self.all()
    sql = "SELECT * FROM sports"
    return Sport.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM sports"
    run(sql)
  end

  def self.map_items(sql)
    sports = run(sql)
    result = sports.map { |sport| Sport.new(sport) }
    return result
  end

  def self.map_item(sql)
    result = map_items(sql)
    return result.first
  end

end