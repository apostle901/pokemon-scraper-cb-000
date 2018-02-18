class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:)
    @id, @name, @type, @db = id, name, type, db
    self.hp = 60
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
  end

  def self.find(id, db)
    hold = db.execute("SELECT * FROM pokemon WHERE (id = ?)", id)
    hold.flatten!
    poke = Pokemon.new(id: hold[0], name: hold[1], type: hold[2], db: db)
    poke
  end

  def alter_hp(health, db)
    self.hp = health
    db.execute("UPDATE pokemon SET hp = (?) WHERE name = (?);", health, self.name)
  end
end
