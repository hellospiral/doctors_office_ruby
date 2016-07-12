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
