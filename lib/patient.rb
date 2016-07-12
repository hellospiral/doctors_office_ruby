class Patient
  attr_reader(:name, :doctor_id, :birth_date, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @doctor_id = attributes.fetch(:doctor_id)
    @birth_date = attributes.fetch(:birth_date)
    @id = attributes.fetch(:id)
  end

  define_method(:==) do |another_patient|
    self.name() == another_patient.name() &&
    self.doctor_id() == another_patient.doctor_id() &&
    self.birth_date() == another_patient.birth_date()
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch('name')
      doctor_id = patient.fetch('doctor_id').to_i()
      birth_date = patient.fetch('birth_date')
      id = patient.fetch('id').to_i()
      patients.push(Patient.new({:name => name, :doctor_id => doctor_id, :birth_date => birth_date, :id => id}))
    end
    patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients(name, doctor_id, birth_date) VALUES ('#{@name}', #{@doctor_id}, '#{@birth_date}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
end
