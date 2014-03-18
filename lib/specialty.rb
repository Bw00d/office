class Specialty

  attr_reader :field, :doc_id, :id

  def initialize(attributes)
    @field = attributes[:field]
    @doc_id = attributes[:doc_id]
    @id = attributes[:id]
  end

  def self.all
    specialties = []
    results = DB.exec("SELECT * FROM specialties;")
    results.each do |result|
      specialties << Specialty.new({:field => result['field'], :doc_id => result['doc_id'].to_i, :id => result['id'].to_i})
    end
    specialties
  end

  def save
    result = DB.exec("INSERT INTO specialties (field) VALUES ('#{@field}') RETURNING  id;")
    @id = result.first['id'].to_i
  end

  def ==(another_specialty)
    self.field == another_specialty.field && self.id == another_specialty.id
  end

  def doc_list
    doctors_in_specialty = []
    p "*****"
    results = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{@id};")
    results.each do |result|
      p result
      doctors_in_specialty << result['name']
    end
    doctors_in_specialty
  end
end
