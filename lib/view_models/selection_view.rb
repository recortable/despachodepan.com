# SelectionCard
# The selected images from all the projects
class SelectionView
  attr_reader :top, :bottom

  def initialize
    #all = Selections.reorder('rev_date ASC, updated_at DESC')
    @top = []
    @bottom = []
    Selections.all.each do |selection|
      if selection.row_position == 'Arriba'
        @top << selection
      else
        @bottom << selection
      end
    end
  end


  def width
    @width ||= calculate_width
  end

  protected
  def calculate_width
    max_top = top.each.map(&:width).map(&:to_i).inject{|sum, n| sum + 10 + n } + 10 || 200
    max_bottom = bottom.each.map(&:width).map(&:to_i).inject{|sum, n| sum + 10 + n } || 200
    max_top > max_bottom ? max_top : max_bottom
  end
end
