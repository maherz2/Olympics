require('date')
require_relative('../db/sql_runner')

class Athlete

attr_reader(:id, :name, :dob, :sex, :height, :weight, :nation_id )
  
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @dob = options['dob']
    @sex = options['sex']
    @height = options['height'].to_i
    @weight = options['weight'].to_i
    @nation_id = options['nation_id'].to_i
  end

  def age()
    birthdate = @dob.split('-')
    return if birthdate.length != 3
    dob = Date.new(birthdate[0].to_i, birthdate[1].to_i, birthdate[2].to_i)
    return Time.now.year - dob.year
  end


  def save()
    sql = "INSERT INTO athletes (name, dob, sex, height, weight, nation_id) 
    VALUES ('#{@name}', '#{@dob}', '#{@sex}', '#{@height}', '#{@weight}', '#{@nation_id}') RETURNING *"
    athlete = run(sql).first
    result = Athlete.new(athlete)
    return result
  end

  def delete()
    sql = "DELETE FROM athletes WHERE id = '#{@id}'"
    run(sql)
  end

  def update(options)
    sql = "UPDATE athletes SET name = '#{options['name']}', 
    dob = '#{options['dob']}',
    sex = '#{options['sex']}',
    height = '#{options['height']}',
    weight = '#{options['weight']}',
    nation_id = '#{options['nation_id']}'
    WHERE id = '#{@id}'"
    run(sql)
  end

  def events()
    sql = "SELECT events.* FROM events
    INNER JOIN athlete_results ON events.id = athlete_results.event_id
    WHERE athlete_results.athlete_id = #{@id}"
    events = Event.map_items(sql)
    sql = "SELECT events.* from events
    INNER JOIN team_results ON team_results.event_id = events.id
    INNER JOIN teams ON team_results.team_id = teams.id
    INNER JOIN team_members ON team_members.team_id = teams.id
    WHERE team_members.athlete_id = #{@id}"
    result = events.concat(Event.map_items(sql))
    return result.uniq {|sport| sport.id}
  end

  def sports()
    sql = "SELECT sports.* FROM sports
    INNER JOIN events ON events.sport_id = sports.id
    INNER JOIN athlete_results ON events.id = athlete_results.event_id
    WHERE athlete_results.athlete_id = #{@id}"
    sports = Sport.map_items(sql)
    sql = "SELECT sports.* FROM sports
    INNER JOIN events ON events.sport_id = sports.id
    INNER JOIN team_results ON team_results.event_id = events.id
    INNER JOIN teams ON team_results.team_id = teams.id
    INNER JOIN team_members ON team_members.team_id = teams.id
    WHERE team_members.athlete_id = #{@id}"
    result = sports.concat(Sport.map_items(sql))
    return result.uniq {|sport| sport.id}
  end

  def teams()
    sql = "SELECT teams.* FROM teams
    INNER JOIN team_members ON team_members.team_id = teams.id
    WHERE team_members.athlete_id = #{@id}"
    return Team.map_items(sql)
  end

  def nation
    sql = "SELECT * FROM nations WHERE id = #{nation_id}"
    return Nation.map_item(sql)
  end

  def medals()
    events = Event.all()
    medals = {}
    medals['gold'] = 0
    medals['silver'] = 0
    medals['bronze'] = 0
     events.each do |event|
      event_medals = event.medals
      if event_medals['gold']
        medals['gold'] += 1 if event_medals['gold'].id == @id
      end
      if event_medals['silver']
        medals['silver'] += 1 if event_medals['silver'].id == @id
      end
      if event_medals['bronze']
        medals['bronze'] += 1 if event_medals['bronze'].id == @id
      end
     end
     return medals
  end


  def self.all()
    sql = "SELECT * FROM athletes"
    return Athlete.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM athletes"
    run(sql)
  end

  def self.map_items(sql)
    athletes = run(sql)
    result = athletes.map { |athlete| Athlete.new(athlete) }
    return result
  end

  def self.map_item(sql)
    result = map_items(sql)
    return result.first
  end

end