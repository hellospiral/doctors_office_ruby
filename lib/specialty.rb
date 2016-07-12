class Specialty
  attr_reader(:name, :id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:==) do |another_specialty|
    self.name().==(another_specialty.name())
  end

  define_singleton_method(:all) do
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each() do |specialty|
      name = specialty.fetch("name")
      id = specialty.fetch("id").to_i()
      specialties.push(Specialty.new({:name => name, :id => id}))
    end
    specialties
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id() == id
        found_specialty = specialty
      end
    end
    found_specialty
  end

  define_method(:doctors) do
    specialty_doctors = []
    doctors = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id()} ORDER BY name ASC;")
    doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id").to_i()
      specialty_doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    specialty_doctors
  end
end
