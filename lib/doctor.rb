class Doctor

  attr_reader :name, :specialty_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty_id = attributes[:specialty_id]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      specialty_id = result['specialty_id'].to_i
      id = result['id'].to_i
      doctors << Doctor.new({:name => name, :specialty_id => specialty_id, :id => id })
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.id == another_doctor.id && self.specialty_id == another_doctor.specialty_id
  end

end
