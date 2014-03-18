require 'spec_helper'

describe Patient do
  describe '#initialize' do
    it 'creates a new patient instance' do
      test_patient = Patient.new({:name =>"Sybil Doe"})
      test_patient.should be_an_instance_of Patient
    end
    it 'gives a patient a name' do
      test_patient = Patient.new({:name =>"Sylvia"})
      test_patient.name.should eq "Sylvia"
    end
  end
  describe '.all' do
    it 'is empty to start' do
      Patient.all.should eq []
    end
  end

  describe '.create' do
    it 'initializes and saves a new patient' do
      test_patient = Patient.create({:name => "Sylvia"})
      test_patient.should be_an_instance_of Patient
    end
  end

  describe '#save' do
    it 'saves a patient to the database' do
      test_patient = Patient.create({:name => "Sylvia"})
      Patient.all.should eq [test_patient]
    end
  end

  describe '#==' do
    it 'compares two patients to see if they have the same name and id' do
      test_patient1 = Patient.new({:name => "Sylvia", :id => 1})
      test_patient2 = Patient.new({:name => "Sylvia", :id => 1})
      test_patient1.should eq test_patient2
    end
  end
end
