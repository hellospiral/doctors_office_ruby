require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctor")
require("./lib/patient")
require("./lib/specialty")
require('pg')

DB = PG.connect({:dbname => "doctors_office_test"})

get('/') do
  erb(:index)
end

get('/specialty/new') do
  erb(:specialty_form)
end

post('/specialties') do
  name = params.fetch('specialty')
  specialty = Specialty.new({name: name, id: nil})
  specialty.save()
  erb(:success)
end


get('/specialties') do
  @specialties = Specialty.all()
  erb(:specialties)
end

get("/specialties/:id") do
  @specialty = Specialty.find(params.fetch("id").to_i())
  erb(:specialty)
end

get("/specialties/:id/doctor/new") do
  @specialty = Specialty.find(params.fetch("id").to_i())
  erb(:doctor_form)
end

post('/doctors') do
  name = params.fetch("name")
  specialty_id = params.fetch("specialty_id").to_i()
  @specialty = Specialty.find(specialty_id)
  @doctor = Doctor.new({name: name, specialty_id: specialty_id, id: nil})
  @doctor.save()
  erb(:success)
end

get("/specialties/:id/doctor/:id1") do
  @specialty = Specialty.find(params.fetch("id").to_i())
  @doctor = Doctor.find(params.fetch("id1").to_i())
  erb(:doctor)
end

get("/specialties/:id/doctor/:id1/patient/new") do
  @specialty = Specialty.find(params.fetch("id").to_i())
  @doctor = Doctor.find(params.fetch("id1").to_i())
  erb(:patient_form)
end

post('/patients') do
  name = params.fetch("name")
  birth_date = params.fetch("birth_date")
  doctor_id = params.fetch("doctor_id").to_i()
  @doctor = Doctor.find(doctor_id)
  @patient = Patient.new({name: name, birth_date: birth_date, doctor_id: doctor_id, id: nil})
  @patient.save()
  erb(:success)
end
