require 'spec_helper'

describe Specialty do
  describe 'initialize' do
    it 'creates a new instance of Specialty' do
      test_specialty = Specialty.new({:field => "Hip Hop", :doc_id => 1})
      test_specialty.should be_an_instance_of Specialty
    end

    it 'gives a name and a doctor id for each instance' do
      test_specialty = Specialty.new({:field => "Hip Hop", :doc_id => 2})
      test_specialty.field.should eq "Hip Hop"
      test_specialty.doc_id.should eq 2
    end
  end

  describe '.all' do
    it 'is an empty array at first' do
      Specialty.all.should eq []
    end
  end

  describe '#save' do
    it 'saves a specialty to the database' do
      test_specialty = Specialty.new({:field => "Hip Hop", :doc_id => 1})
      test_specialty.save
      Specialty.all.should eq [test_specialty]
    end
  end

  describe '#==' do
    it 'compares two specialties deeply' do
      test_specialty1 = Specialty.new({:field => "Hip Hop", :doc_id => 1, :id => 5})
      test_specialty2 = Specialty.new({:field => "Hip Hop", :doc_id => 1, :id => 5})
      test_specialty1.should eq test_specialty2
    end
  end

  describe '#doc_list' do
    it 'should return a list of doctors ids with given specialty' do
      test_specialty1 = Specialty.new({:field => "Hip Hop"})
      test_specialty3 = Specialty.new({:field => "Geriatrics"})
      test_specialty1.save
      test_specialty3.save
      test_doc1 = Doctor.new({:name => "Dr. Dre", :specialty_id => test_specialty1.id, :id => 2})
      test_doc2 = Doctor.new({:name => "Dr. Pepper", :specialty_id => test_specialty1.id, :id => 1})
      test_doc3 = Doctor.new({:name => "Dr. Ruth", :specialty_id => test_specialty3.id, :id => 5})
      test_doc1.save
      test_doc2.save
      test_doc3.save
      test_specialty1.doc_list.should eq ["Dr. Dre", "Dr. Pepper"]
    end
  end
end



