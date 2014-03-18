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
    result = DB.exec("INSERT INTO specialties (field, doc_id) VALUES ('#{@field}', #{@doc_id}) RETURNING  id;")
    @id = result.first['id'].to_i
  end

  def ==(another_specialty)
    self.field == another_specialty.field && self.doc_id == another_specialty.doc_id && self.id == another_specialty.id
  end

  def self.doc_list(field_to_select)
    doctors_in_specialty = []
    results = DB.exec("SELECT * FROM specialties WHERE field = '#{field_to_select}';")
    results.each do |result|
      p result
      doctors_in_specialty << result['doc_id'].to_i
    end
    doctors_in_specialty
  end
end
