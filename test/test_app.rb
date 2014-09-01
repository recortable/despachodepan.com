require_relative '../lib/despachodepan'
require_relative '../helpers/despachodepan_helpers'
require_relative '../helpers/card_helpers'
Despachodepan.load

class HelperTest
  include CardHelpers
  include DespachodepanHelpers
end

slide = Repo.find('SlideImage', 91)
puts slide.timeline_position
