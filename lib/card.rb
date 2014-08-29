Card = Struct.new(:id, :title, :text, :properties, :main_image_id, :vposition,
 :start, :finish, :color_id, :visible, :main_slide_id, :main_file_id, :link,
 :created_at, :updated_at, :url, :slides_count, :selected, :selection_image_id,
 :selection_body, :selection_position, :slug) do

   def color
     Colors.find(color_id)
   end

   def visible?
     visible == true
   end
end

class Cards
  def self.load
    @cards = YAML::load_file(File.join(__dir__, 'data', 'cards.yml'))
    @cards_by_id = Hash[@cards.map {|card| [card.id.to_i, card] }]
    puts "Cards: #{@cards.size}"
  end

  def self.find(id)
    @cards_by_id[id.to_i]
  end
end
