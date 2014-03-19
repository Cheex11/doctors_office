require './lib/doctor'
require './lib/patient'
require 'pg'

DB = PG.connect(:dbname =>'doctors_office')

def main_menu
  system('clear')
  list_doctors
  puts ('press "add DOCTOR SPECIALTY" to add a doctor')
  puts ('press "v name" to view a doctor')
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
  elsif input[0] == 'v'
    view_doctor(input[1])
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
    puts "#{doc.name}: #{doc.specialty}.  ID = #{doc.id}"
  end
end

def add_doctor(name, specialty)
  new_doctor = Doctor.create({'name' => name,'specialty' => specialty})
  main_menu
end

def patient_menu
  patients = Patient.all
  patients.each do |patient|
    # puts (patient.doctor_id)
    puts "#{patient.id} => #{patient.name}'s Birthdate: #{patient.birthdate}, Doctor: #{patient.doctor_name}"
  end

  puts ("press 'a' to add a patient")
  puts ("press 'm' to return to the main menu")
  input = gets.chomp

  if input == 'a'
    add_patient_menu
  elsif input == 'm'
    main_menu
  end
end

def view_doctor(doctor_name)
  system('clear')
  doctor = Doctor.get_doctor_by_name(doctor_name)
  puts (doctor['name'] + ':')



  puts ('accepts:')
  puts ('specializes in:')
  puts ('patients:')
    # list_patients(doctor_name)

  # puts ("press 'a' to add insurance information for this doctor")
  # input = gets.chomp
  # puts ("What insurance does this doctor accept?")
  # input = gets.chomp
  #   DOCTOR.add_insurance_informaiton(input)
  # main_menu
end

def add_patient_menu
  puts ("What is the patient's name?")
  new_patient_name = gets.chomp
  puts ("What is the patient's birthdate?")
  new_patient_birthdate = gets.chomp
  puts ("What is the new patient's doctor's ID?")
  new_patient_doctor_id = gets.chomp.to_i
  Patient.create({'name' => new_patient_name, 'birthdate' => new_patient_birthdate, 'doctor_id' => new_patient_doctor_id})
  patient_menu
end



    main_menu
