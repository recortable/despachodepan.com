Color = Struct.new(:id, :name, :value, :high_value) do

end

class Colors
  def self.load
    @colors = YAML::load_file(File.join(__dir__, 'data', 'colors.yml'))
    @colors_by_id = Hash[@colors.map {|color| [color.id.to_i, color] }]
    puts "Cards: #{@colors.size}"
  end

  def self.find(id)
    @colors_by_id[id.to_i]
  end
end
