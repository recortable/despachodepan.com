Card = Struct.new(:id, :title, :text, :properties, :main_image_id, :vposition,
 :start, :finish, :color_id, :visible, :main_slide_id, :main_file_id, :link,
 :created_at, :updated_at, :url, :slides_count, :selected, :selection_image_id,
 :selection_body, :selection_position, :slug) do

  BEGIN_YEAR = 2001
  BLOCS_PER_YEAR = 16
  DAYS_PER_BLOC = 365 / 16

   def color
     Colors.find(color_id)
   end

   def visible?
     visible == true
   end

   def displayable?
     visible? and start.present? and vposition.present?
   end

  def begin_column
    date_to_column(parse_date(start))
  end

  def end_column
    if finish.nil? || finish.empty?
      date_to_column(Date.today)
    else
      date_to_column(parse_date(finish))
    end
  end

   private
    def parse_date(str_date)
      a = str_date.split('/').map { |str| str.to_i }
      Date.new(a[2], a[1], a[0])
    end

    def date_to_column(date)
      year = date.year - BEGIN_YEAR
      offset = date.yday / DAYS_PER_BLOC
      year * BLOCS_PER_YEAR + offset
    end
end

class Cards
  def self.load
    @cards = Repository.load('Cards')
    @cards_by_id = Repository.index_by_id(@cards)
  end

  def self.all
    @cards
  end

  def self.find(id)
    @cards_by_id[id.to_i]
  end
end
