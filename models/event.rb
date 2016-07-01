class Event

attr_reader(:id, :name, :participation_type, :max_capacity, :world_record, :sport_id)
  
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @participation_type = options['participation_type']
    @max_capacity = options['max_capacity'].to_i
    @world_record = options['world_record']
    @sport_id = options['sport_id'].to_i
  end

  def save()
    sql = "INSERT INTO events (name, participation_type, max_capacity, world_record, sport_id) 
    VALUES ('#{@name}', '#{@participation_type}', '#{@max_capacity}', '#{@world_record}', '#{@sport_id}') RETURNING *"
    event = run(sql).first
    result = Event.new(event)
    return result
  end

  def delete()
    sql = "DELETE FROM events WHERE id = '#{@id}'"
    run(sql)
  end

  def update(options)
    sql = "UPDATE events SET name = '#{options['name']},
    participation_type = '#{options['participation_type']},
    max_capacity = '#{options['max_capacity']},
    world_record = '#{options['world_record']},
    sport_id = '#{options['sport_id']}
     WHERE id = '#{@id}'"
    run(sql)
  end

  def self.all()
    sql = "SELECT * FROM events"
    return Event.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM events"
    run(sql)
  end

  def self.map_items(sql)
    events = run(sql)
    result = events.map { |event| Event.new(event) }
    return result
  end

  def self.map_item(sql)
    result = map_items(sql)
    return result.first
  end

end