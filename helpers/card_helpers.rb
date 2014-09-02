module CardHelpers
  BEGIN_YEAR = 2001
  BLOCS_PER_YEAR = 16
  DAYS_PER_BLOC = 365 / 16

  def card_properties(card)
    properties = []
    card.properties.each_line do |line|
      splitted = line.split(%r{:\s})
      splitted[0], splitted[1] = '', splitted[0] if splitted.length == 1
      properties << splitted
    end
    properties
  end

  def visible_card?(card)
    card.visible == true
  end

  def displayable_card?(card)
    card.visible == true and card.start.present? and card.vposition.present?
  end

 def begin_column(card)
   date_to_column(parse_date(card.start))
 end

 def end_column(card)
   if card.finish.nil? || card.finish.empty?
     date_to_column(Date.today)
   else
     date_to_column(parse_date(card.finish))
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
