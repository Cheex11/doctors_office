require 'rspec'
require 'patient'
require 'doctor'
require 'pg'

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
  end
end

describe Patient do
  it 'starts with no tasks' do
    Patient.all.should eq []
  end

  describe 'initialize' do
    it 'should initialize Patient' do
      patient = Patient.new({'name' => 'bob', 'birthdate' => '2000-01-01', 'doctor_id' => 1})
      patient.should be_an_instance_of Patient
    end
  end

  describe 'create' do
    it 'should create a new Patient' do
      patient = Patient.create({'name' => 'bob', 'birthdate' => '2000-01-01', 'doctor_id' => 1})
      patient.should be_an_instance_of Patient
      patient.name.should eq 'bob'
    end
  end

  describe 'doctor_name' do
    it 'should return the doctors name for a patient' do
      doctor = Doctor.create({'name' => 'Dr. Pepper', 'specialty' => 'oncology'})
      patient = Patient.create({'name' => 'bob', 'birthdate' => '2000-01-01', 'doctor_id' => doctor.id})
      patient.doctor_name.should eq "Dr. Pepper"
    end

    it 'should return the doctors name for a patient' do
      doctor = Doctor.create({'name' => 'Dr. Pepper', 'specialty' => 'oncology'})
      patient = Patient.create({'name' => 'bob', 'birthdate' => '2000-01-01'})
      patient.doctor_name.should eq "no doctor"
    end
  end

  describe 'save' do
    it 'lets you save a patient to the database' do
      patient = Patient.new({'name' => 'bob', 'birthdate' => '2000-01-01', 'doctor_id' => 0})
      patient.save
      Patient.all.should eq [patient]
    end
  end
end
