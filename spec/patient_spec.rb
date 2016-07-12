require('spec_helper')

describe(Patient) do
  describe("#name") do
    it("should return the name of the patient") do
      test_patient = Patient.new(:name => "Mike Jones", :doctor_id => 1, :birth_date => '1999-01-01', :id => nil)
      expect(test_patient.name()).to(eq("Mike Jones"))
    end
  end

  describe("#doctor_id") do
    it("should return the doctor id of the patient") do
      test_patient = Patient.new(:name => "Mike Jones", :doctor_id => 1, :birth_date => '1999-01-01', :id => nil)
      expect(test_patient.doctor_id()).to(eq(1))
    end
  end

  describe("#birth_date") do
    it("should return the birth date of the patient") do
      test_patient = Patient.new(:name => "Mike Jones", :doctor_id => 1, :birth_date => '1999-01-01', :id => nil)
      expect(test_patient.birth_date()).to(eq('1999-01-01'))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same name, doctor id, birthdate") do
      patient1 = Patient.new({:name => 'Mike Jones', :doctor_id => 1, :birth_date => '1999-01-01', :id => nil})
      patient2 = Patient.new({:name => 'Mike Jones', :doctor_id => 1, :birth_date => '1999-01-01', :id => nil})
      expect(patient1).to(eq(patient2))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a patient to the array of saved patients") do
      test_patient = Patient.new(:name => "Mike Jones", :doctor_id => 1, :birth_date => '1999-01-01', :id => nil)
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end
end
