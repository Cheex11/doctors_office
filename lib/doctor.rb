require 'pg'

class Doctor

  attr_reader :id, :name, :specialty, :doctors

  def initialize(attributes)
    @name = attributes[:name]
    @specialty = attributes[:specialty]
    @id = attributes[:id]
  end

  def self.create(attributes)
    doc = Doctor.new(attributes)
    doc.save
    doc
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      puts('something')

      # atts[:id] = result['id']
      # atts[:name] = result['name']
      # atts[:specialty] = result['specialty']
      # puts (atts)
      # doctors << Doctor.new(atts)

      name = result['name']
      specialty = result['specialty']
      id = result['id'].to_i
      doctors << Doctor.new({:name => name, :specialty => specialty, :id => id})
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty) values ('#{@name}', '#{@specialty}') RETURNING id")
    @id = result.first['id'].to_i
  end

  def ==(another_list)
    self.name == another_list.name
  end

end
