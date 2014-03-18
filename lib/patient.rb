class Patient

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      name = result['name']
      id   = result['id'].to_i
      patients << Patient.new({:name => name, :id => id})
    end
  patients
  end

  def self.create(attributes)
    new_patient = Patient.new(attributes)
    new_patient.save
    new_patient
  end

  def save
    result = DB.exec("INSERT INTO patients (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_patient)
    self.name == another_patient.name && self.id == another_patient.id
  end
end
