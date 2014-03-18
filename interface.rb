require './lib/doctor'
require './lib/patient'
require 'pg'

DB = PG.connect(:dbname =>'doctors_office')

def main_menu
  list_doctors
  puts ('press "add DOCTOR SPECIALTY" to add a doctor')
  puts ('press "v #" to view a doctor')
  puts ('press "delete DOCTOR_NAME" to delete a doctor')
  puts ('press "x" to exit')
  puts ('press "p" to see Patients')
  input = gets.chomp.split

  if input[0] == 'add'
    input.shift
    add_doctor(input[0], input[1])
  elsif input[0] == 'delete'
    input.shift
    DB.exec("DELETE FROM doctors WHERE name = '#{input[0]}';")
    main_menu
  elsif input[0] == 'x'
    puts 'exiting'
  elsif input[0] = 'p'
    system('clear')
    patient_menu
  else
    puts 'enter a valid option'
    sleep(2)
    main_menu
  end
end

def list_doctors
  docs = Doctor.all
  docs.each do |doc|
    puts "#{doc.name}: #{doc.specialty}"
  end
end

def add_doctor(name, specialty)
  new_doctor = Doctor.create({:name => name, :specialty => specialty})
  main_menu
end

def patient_menu
  patients = Patients.all_with_doctor
  patients.each do |patient|
    puts "#{patient.id} => #{patient.name}'s Birthdate: #{patient.dob}, Doctor: #{patient.doctor}"
    main_menu
