require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new specialty', {:type => :feature}) do
  it('allows a user to add a specialty') do
    visit('/')
    click_link("Add New Specialty")
    fill_in("specialty", :with => "Cardiologist")
    click_button("Add Specialty")
    expect(page).to have_content("Success")
  end
end

describe('the view specialties path', {:type => :feature}) do
  it('views a list of all the specialties') do
    test_specialty = Specialty.new({name: 'cardiology', id: nil})
    test_specialty.save()
    test_specialty2 = Specialty.new({name: 'pediatrics', id: nil})
    test_specialty2.save()
    visit('/specialties')
    expect(page).to have_content(test_specialty.name())
    expect(page).to have_content(test_specialty2.name())
  end
end

describe('the view specialty path', {:type => :feature}) do
  it('views a particular specialty') do
    test_specialty = Specialty.new({name: 'cardiology', id: nil})
    test_specialty.save()
    visit('/specialties')
    click_link(test_specialty.name())
    expect(page).to have_content(test_specialty.name())
  end
end

describe('add doctor to a specialty', {:type => :feature}) do
  it('allows the user to add a doctor from a specialty') do
    test_specialty = Specialty.new({name: 'cardiology', id: nil})
    test_specialty.save()
    visit("/specialties/#{test_specialty.id()}")
    click_link("Add a Doctor")
    fill_in('name', :with=> "Mike Jones")
    click_button("Add Doctor")
    expect(page).to have_content("Success")
  end
end

describe("add patient to a doctor", {:type => :feature}) do
  it('views a doctors patients') do
    test_specialty = Specialty.new({name: 'cardiology', id: nil})
    test_specialty.save()
    visit("/specialties/#{test_specialty.id()}")
    test_doctor = Doctor.new({:name => 'Hamilton', :specialty_id => test_specialty.id(), :id => nil})
    test_doctor.save()
    visit("/specialties/#{test_specialty.id()}/doctor/#{test_doctor.id()}")
    expect(page).to have_content("#{test_doctor.name()}'s patients:")
    click_link("Add Patient")
    expect(page).to have_content("Add A Patient for Dr. #{test_doctor.name()}")
  end

  it('renders the new patient form and renders success page') do
    test_specialty = Specialty.new({name: 'cardiology', id: nil})
    test_specialty.save()
    test_doctor = Doctor.new({:name => 'Hamilton', :specialty_id => test_specialty.id(), :id => nil})
    test_doctor.save()
    visit("/specialties/#{test_specialty.id()}/doctor/#{test_doctor.id()}/patient/new")
    fill_in('name', :with => "Margaret Thatcher")
    fill_in('birth_date', :with => '1999-01-01')
    click_button("Add Patient")
    expect(page).to have_content("Success")
  end
end
