Card = Struct.new(:id, :title, :text, :properties, :main_image_id, :vposition,
 :start, :finish, :color_id, :visible, :main_slide_id, :main_file_id, :link,
 :created_at, :updated_at, :url, :slides_count, :selected, :selection_image_id,
 :selection_body, :selection_position, :slug) do

   def color
     @color ||= Repo.find('Color', color_id)
   end

   def main_slide
     Repo.find('MainImage', main_slide_id)
   end

   def slide_images
     @slide_images ||= Repo.all('SlideImage').select {|image| image.card_id == id}
   end
end

Color = Struct.new(:id, :name, :value, :high_value) do
end

Tag = Struct.new(:id, :name, :position, :color_id) do

  def color
    @color ||= Repo.find('Color', color_id)
  end
end

CardTag = Struct.new(:card_id, :tag_id) do
end


AmazonFile = Struct.new(:name, :prefix, :id) do
  def url
    "https://depan.s3.amazonaws.com/#{prefix.downcase}/file/#{id}/#{name}"
  end
end

Pan = Struct.new(:id, :type, :card_id, :text, :position,
  :date, :body, :rev_date, :content_type, :size, :width, :height, :file,
  :original_id, :created_at, :updated_at, :settings) do

    def card
      Repo.find('Card', card_id)
    end

    def upfile
      @file ||= AmazonFile.new(file, self.class.to_s, id)
    end
end

class Post < Pan
end

class Selection < Pan
  def row_position
    'Arriba' if settings.include? 'Arriba'
  end
end

class MainImage < Pan
end

class SlideImage < Pan
  def timeline_position
    load_settings
    @settings[:timeline_position]
  end

  def load_settings
    @settings = YAML.load(settings)
  end
end

class PanFile < Pan
end
