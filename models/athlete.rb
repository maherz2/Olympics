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