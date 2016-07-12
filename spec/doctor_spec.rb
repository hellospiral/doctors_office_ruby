require('spec_helper')

describe(Doctor) do
  describe('#==') do
    it('is the same doctor if it has the same name and specialty_id') do
      test_doctor = Doctor.new({:name => 'Mike Jones', :specialty_id => 1, :id => nil})
      test_doctor2 = Doctor.new({:name => 'Mike Jones', :specialty_id => 1, :id => nil})
      expect(test_doctor).to(eq(test_doctor2))
    end
  end

  describe(".all") do
    it('is empty at first') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a doctor to the array of saved doctors') do
      test_doctor = Doctor.new({:name => 'Mike Jones', :specialty_id => 1, :id => nil})
      test_doctor.save()
      expect(Doctor.all()).to(eq([test_doctor]))
    end
  end

  describe('#name') do
    it('should return the name of a doctor') do
      test_doctor = Doctor.new({:name => 'Mike Jones', :specialty_id => 1, :id => nil})
      expect(test_doctor.name()).to(eq('Mike Jones'))
    end
  end

  describe('#specialty_id') do
    it('should return the specialty id of a doctor') do
      test_doctor = Doctor.new({:name => 'Mike Jones', :specialty_id => 1, :id => nil})
      expect(test_doctor.specialty_id()).to(eq(1))
    end
  end

  describe('#patients') do
    it('returns an array of patients belonging to a doctor') do
      test_doctor = Doctor.new({:name => "Bob Williams", :specialty_id => 1, :id => nil})
      test_doctor.save()
      test_patient = Patient.new({:name => "James Smith", :doctor_id => test_doctor.id(), :birth_date => '2000-01-01', :id => nil})
      test_patient.save()
      expect(test_doctor.patients()).to(eq([test_patient]))
    end
  end

  describe('.find') do
    it('returns a doctor by its ID') do
      test_doctor = Doctor.new({:name => "Bob Williams", :specialty_id => 1, :id => nil})
      test_doctor.save()
      expect(Doctor.find(test_doctor.id())).to(eq(test_doctor))
    end
  end

  describe('#number_of_patients') do
    it('returns the number of patients assigned to a doctor') do
      test_doctor = Doctor.new({:name => 'Bob Williams', :specialty_id => 1, :id => nil})
      test_doctor.save()
      test_patient = Patient.new({:name => "Buck Jones", :birth_date => '1980-03-21', :doctor_id => test_doctor.id(), :id => nil})
      test_patient.save()
      test_patient2 = Patient.new({:name => "Mike Smith", :birth_date => '1981-03-21', :doctor_id => test_doctor.id(), :id => nil})
      test_patient2.save()
      expect(test_doctor.number_of_patients()).to(eq(2))
    end
  end
end
