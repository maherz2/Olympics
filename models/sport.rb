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