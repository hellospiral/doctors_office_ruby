require('spec_helper')

describe(Specialty) do
  describe("#name") do
    it("should return the name of the specialty") do
      test_specialty = Specialty.new({:name => 'cardiologist', :id => nil})
      expect(test_specialty.name()).to(eq('cardiologist'))
    end
  end

  describe("#==") do
    it('is the same specialty if it has the same name') do
      specialty1 = Specialty.new({:name => 'cardiologist', :id => nil})
      specialty2 = Specialty.new({:name => 'cardiologist', :id => nil})
      expect(specialty1).to(eq(specialty2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Specialty.all()).to(eq([]))
    end

    it('returns an array containing all instances of Specialty') do
      specialty1 = Specialty.new({:name => 'cardiologist', :id => nil})
      specialty1.save()
      specialty2 = Specialty.new({:name => 'pediatrician', :id => nil})
      specialty2.save()
      expect(Specialty.all()).to(eq([specialty1, specialty2]))
    end
  end

  describe('#save') do
    it('adds a specialty to the array of saved specialties') do
      test_specialty = Specialty.new({:name => 'cardiologist', :id => nil})
      test_specialty.save()
      expect(Specialty.all()).to(eq([test_specialty]))
    end
  end

  describe('.find') do
    it('returns a specialty by its ID') do
      test_specialty = Specialty.new({:name => "cardiologist", :id => nil})
      test_specialty.save()
      expect(Specialty.find(test_specialty.id())).to(eq(test_specialty))
    end
  end

  describe('#doctors') do
    it('returns an array of doctors belonging to a specialty') do
      test_specialty = Specialty.new({:name => "cardiologist", :id => nil})
      test_specialty.save()
      test_doctor = Doctor.new({:name => "James Smith", :specialty_id => test_specialty.id(), :id => nil})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Bob Smith", :specialty_id => test_specialty.id(), :id => nil})
      test_doctor2.save()
      test_doctor3 = Doctor.new({:name => "Barbara Smith", :specialty_id => test_specialty.id(), :id => nil})
      test_doctor3.save()
      expect(test_specialty.doctors()).to(eq([test_doctor3, test_doctor2, test_doctor]))
    end
  end
end
