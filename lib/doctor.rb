require 'pg'

class Doctor

  attr_reader :id, :name, :specialty, :doctors

  def initialize(attributes)
    @name = attributes['name']
    @specialty = attributes['specialty']
    @id = attributes['id']
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
      # puts result
      # name = result['name']
      # specialty = result['specialty']
      # id = result['id'].to_i
      doctors << Doctor.new(result)
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty) values ('#{@name}', '#{@specialty}') RETURNING id")
    @id = result.first['id'].to_i
  end

  def add_insurance(provider)
    insurance_id = DB.exec("SELECT id FROM insurance_companies WHERE insurance = '#{provider}'")

    DB.exec("INSERT INTO doctors (accepts) values ('#{insurance_id[0]}');")
    provider
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.get_doctor_by_name(name)
    result = DB.exec("SELECT * FROM doctors WHERE name = '#{name}'")
    result[0]
  end

end
