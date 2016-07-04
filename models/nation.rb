require_relative('nation')


class Nation

attr_reader(:id, :name, :flag_url, :population, :continent )
  
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @continent = options['continent']
    @flag_url = options['flag_url']
    @population = options['population'].to_i
  end

  def save()
    sql = "INSERT INTO nations (name, flag_url, population) 
    VALUES ('#{@name}', '#{@flag_url}', '#{@population}') RETURNING *"
    nation = run(sql).first
    result = Nation.new(nation)
    return result
  end

  def delete()
    sql = "DELETE FROM nations WHERE id = '#{@id}'"
    run(sql)
  end

  def update(options)
    sql = "UPDATE nations SET name = '#{options['name']}', 
    flag_url = '#{options['flag_url']}',
    population = '#{options['population']}'
    WHERE id = '#{@id}'"
    run(sql)
  end

  def athletes()
    sql = "SELECT * FROM athletes WHERE nation_id = #{@id}"
    return Athlete.map_items(sql)
  end

  def medals()
    athletes = athletes()
    national_medals = {}
    national_medals['gold'] = 0
    national_medals['silver'] = 0
    national_medals['bronze'] = 0

    athletes.each do |athlete|
      athlete_medals = athlete.medals
      national_medals['gold'] = national_medals['gold'] + athlete_medals['gold']
      national_medals['silver'] = national_medals['silver'] + athlete_medals['silver']
      national_medals['bronze'] = national_medals['bronze'] + athlete_medals['bronze']
    end
    return national_medals
  end

  def points()
    medals = medals()
    points = 0
    points = points + (medals['gold'] * 5)
    points = points + (medals['silver'] * 3)
    points = points + (medals['bronze'] * 1)
    return points
  end

  def update(options)
    @name = options['name'] if options['name']
    @flag_url = options['flag_url'] if options['flag_url']
    @population = options['population'] if options['population']

    sql = "UPDATE nations SET name = '#{@name}', flag_url = '#{flag_url}', population = '#{population}' WHERE id = #{@id}"
    
    run(sql)
  end

  def self.all()
    sql = "SELECT * FROM nations"
    return Nation.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM nations"
    run(sql)
  end

  def self.map_items(sql)
    nations = run(sql)
    result = nations.map { |nation| Nation.new(nation) }
    return result
  end

  def self.map_item(sql)
    result = map_items(sql)
    return result.first
  end

  def self.find(id)
    sql = "SELECT * FROM nations WHERE id = #{id}"
    return Nation.map_item(sql)
  end

  def self.search(name)
    return if name == ""
    sql = "SELECT * FROM nations WHERE name LIKE '%#{name}%'"
    return Nation.map_items(sql)
  end

  def self.continent(continent)
    sql = "SELECT * nations WHERE continent = '#{continent}'"
    return Nation.map_items(sql)
  end

end