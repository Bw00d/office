require './lib/doctor'
require './lib/patient'
require './lib/specialty'

def prompt
  print '>'
end

def main
  puts "D add a Doctor"
  puts "P add a Patient"
  puts "X to exit progran"
  result = gets.chomp.upcase

  case result
  when "D"
    add_doctor
  when "P"
    add_patient
  when "X"
    exit
  else
    puts "Invalid input"
  end
  main
end

def add_doctor
  puts "Here's where you will enter the doctor's name and specialty"
  main
end

def add_patient
  puts "Here's where you will enter a patient's name, birthdate and doctor"
  main
end

system "clear"
puts "Welcome to the Patient Manager\n\n"
main
