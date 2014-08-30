
class Selection < Pan
  def row_position
    'Arriba' if settings.include? 'Arriba'
  end
end

class Selections
  def self.load
    @selections = Repository.load('Selections')
    @selections.sort_by! {|selection| selection.rev_date }
    puts "Selections: #{@selections.size}"
  end

  def self.all
    @selections
  end
end
