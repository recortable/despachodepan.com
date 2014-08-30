
Tag = Struct.new(:id, :name, :position, :color_id) do

  def color
    @color ||= Colors.find(color_id)
  end
end

CardTag = Struct.new(:card_id, :tag_id) do
end

class Tags
  def self.load
    @tags = Repository.load('Tags')
    @tags.sort_by! {|post| post.position }
    @card_tags = Repository.load('Cardtags')
  end

  def self.all
    @tags
  end

end
