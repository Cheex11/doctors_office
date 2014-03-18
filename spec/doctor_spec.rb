require 'rspec'
require 'doctor'

describe 'doctor'  do
  it 'is initialized with a name and specialty' do
    doctor = Doctor.new('Dr. A', 'obgyn')
    doctor.should be_an_instance_of Doctor
  end
  it 'has a name and specialty' do
    doctor = Doctor.new('Dr. Pepper', 'obgyn')
    doctor.specialty.should eql 'obgyn'
  end
end
