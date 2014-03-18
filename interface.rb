require './lib/doctor'
require './lib/patient'
require 'pg'

DB = PG.connect(:dbname =>'doctors_office')

def main_menu
  list_doctors
  puts ('press "add DOCTOR" to add a doctor')
  puts ('press "v #" to view a doctor')
  input = gets.chomp.split

  if input[0] == 'add'
    input.shift
    add_doctor(input.join(' '))
  end

end

def list_doctors
  puts ('doctors:')
  docs = Doctors.all
  docs.each do |doc|
    puts "#{doc.name}: #{doc.specialty}"
  end
end

def add_doctor(name)

end



  main_menu
