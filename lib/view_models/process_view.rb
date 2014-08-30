class ProcessView
  attr_reader :scroll_time, :cards, :tags

  def initialize(time)
    @scroll_time = time
    @cards = Cards.all
    @tags = Tags.all
  end
end
