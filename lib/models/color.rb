Color = Struct.new(:id, :name, :value, :high_value) do

end

class Colors
  def self.load
    @colors = Repository.load('Colors')
    @colors_by_id = Repository.index_by_id(@colors)
  end

  def self.find(id)
    @colors_by_id[id.to_i]
  end
end
