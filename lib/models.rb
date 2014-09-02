Card = Struct.new(:id, :title, :text, :properties, :main_image_id, :vposition,
 :start, :finish, :color_id, :visible, :main_slide_id, :main_file_id, :link,
 :created_at, :updated_at, :url, :slides_count, :selected, :selection_image_id,
 :selection_body, :selection_position, :slug) do

  NAMED = {lapanaderia: 1, casamasomenos: 72}

  def ids
    @ids ||= id.to_s
  end

   def color
     @color ||= Repo.find('Color', color_id)
   end

   def main_slide
     @main_slide ||= Repo.all('SlideImage').find {|i| i.card_id == ids}
   end

   def main_image
     @main_image ||= Repo.all('MainImage').find {|i| i.card_id == ids}
   end

   def slide_images
     # TODO: order
     @slide_images ||= Repo.all('SlideImage').select {|image| image.card_id == ids}
   end

   def pan_files
     @pan_files ||= Repo.all('PanFile').select {|file| file.card_id == ids }
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
  def url(type = '')
    filename = type == '' ? name : "#{type}_#{name}"
    "https://depan.s3.amazonaws.com/#{prefix.downcase}/file/#{id}/#{filename}"
  end
end

Pan = Struct.new(:id, :type, :card_id, :text, :position,
  :date, :body, :rev_date, :content_type, :size, :width, :height, :file,
  :original_id, :created_at, :updated_at, :settings) do

    def card
      Repo.find('Card', card_id)
    end

    def upfile
      @file ||= AmazonFile.new(file, self.class.to_s.underscore, id)
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
    get_setting :timeline_position
  end

  def text_align
    get_setting :text_align
  end

  def get_setting(name)
    @settings ||= YAML.load(settings)
    @settings[name]
  end
end

class PanFile < Pan
end
