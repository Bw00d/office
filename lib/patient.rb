class Patient

  attr_reader :name, :id, :birthdate, :doc_id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @birthdate = attributes[:birthdate]
    @doc_id = attributes[:doc_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      name = result['name']
      id   = result['id'].to_i
      doc_id = result['doc_id'].to_i
      birthdate = result['birthdate']
      patients << Patient.new({:name => name, :id => id, :birthdate => birthdate, :doc_id => doc_id})
    end
  patients
  end

  def self.create(attributes)
    new_patient = Patient.new(attributes)
    new_patient.save
    new_patient
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthdate, doc_id) VALUES ('#{@name}', '#{@birthdate}', '#{@doc_id}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM patients WHERE id = #{@id};")
  end

  def modify(attributes)
    @name =  attributes[:name].nil? ? @name : attributes[:name]
    @birthdate = attributes[:birthdate].nil? ? @birthdate : attributes[:birthdate]
    @doc_id = attributes[:doc_id].nil? ? @doc_id : attributes[:doc_id]
    updated = DB.exec("UPDATE patients SET name = '#{@name}' WHERE id = #{@id};") # add birthdate and doc_id to this update...
  end

  def ==(another_patient)
    self.name == another_patient.name && self.id == another_patient.id && self.birthdate == another_patient.birthdate && self.doc_id == another_patient.doc_id
  end
end
