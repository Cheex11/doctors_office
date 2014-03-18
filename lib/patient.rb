require 'pg'

class Patient

  attr_reader :name, :birthdate, :doctor_id, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @doctor_id = attributes['doctor_id']
  end

  def self.create(attributes)
    patient = Patient.new(attributes)
    patient.save
    patient
  end

  def ==(another_patient)
    self.name == another_patient.name
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      patients << Patient.new(result)
    end
    patients
  end

  def doctor_name
    if @doctor_id.to_i == 0
      'no doctor'
    else
      result = DB.exec("SELECT name FROM doctors WHERE id = #{@doctor_id}")
      result[0]['name']
    end
  end


  def save
    if !@doctor_id
      @doctor_id = 0
    end
    result = DB.exec("INSERT INTO patients (name, birthdate, doctor_id) values ('#{@name}', '#{@birthdate}', #{doctor_id}) RETURNING id;")
    @id = result.first['id']
  end
end

