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
