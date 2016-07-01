require_relative('nation')


class Nation

attr_reader(:id, :name, :flag_url, :population )
  
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
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

end