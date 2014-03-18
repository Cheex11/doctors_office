require 'rspec'
require 'doctor'
require 'pg'

DB = PG.connect(:dbname =>'doctors_office_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

DB.exec("DELETE FROM doctors WHERE id > 0")

describe 'doctor'  do
  it 'starts off with no doctors' do
    Doctor.all.should eq []
  end

  it 'is initialized with a name and specialty' do
    doctor = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'obgyn'})
    doctor.should be_an_instance_of Doctor
  end
  it 'has a name and specialty' do
    doctor = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'obgyn'})
    doctor.specialty.should eql 'obgyn'
  end
  describe 'Doctor.all' do
    it 'should list all the doctors' do
      docs = []
      docs << Doctor.create({'name' => 'Dr. Pepper', 'specialty' => 'proc'})
      docs << Doctor.create({'name' => 'Dr. Salt', 'specialty' => 'obgyn'})
      Doctor.all.should eq docs
    end
  end
  describe 'Doctor.create' do
    it 'should create a Doctor object' do
      doc = Doctor.create({'name' => 'Doctor Doo Little', 'specialty' => 'Pathologist'})
      doc.id.should be_an_instance_of Fixnum
    end
  end
end
