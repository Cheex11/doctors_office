require 'pg'

class Patient

  attr_reader :name, :birthdate, :doctor_id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @doctor_id = attributes['doctor_id']
  end

  def self.create(attributes)
    patient = Patient.new(attributes)
    puts patient
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

  def self.all_with_doctor
    #results = DB.exec("SELECT * FROM patients;")
     results = DB.exec("SELECT patients.id, patients.name, patients.birthdate, doctors.name AS doc_name
                        FROM doctors LEFT JOIN patients ON patients.doctor_id = doctors.id")
      # results = DB.exec("SELECT patients.id, patients.name, patients.birthdate, doctors.name AS doc_name
      #                     FROM patients, doctors WHERE doctors.id = patients.doctor_id")

    patients = []
    results.each do |result|
      puts result
      patients << result
    end
    patients
  end


  def save
    result = DB.exec("INSERT INTO patients (name, birthdate, doctor_id) values ('#{@name}', '#{@birthdate}', #{doctor_id}) RETURNING id;")
    @id = result.first['id']
  end
end

