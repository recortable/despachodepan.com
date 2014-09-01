module ProcessHelpers
  def process_view(time)
    @process_view ||= ProcessView.new(time)
  end

  class ProcessView
    attr_reader :scroll_time, :cards, :tags

    def initialize(time)
      @scroll_time = time
      @cards = Repo.all('Card')
      @tags = Repo.all('Tag')
    end
  end


end
