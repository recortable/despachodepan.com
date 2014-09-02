require_relative '../lib/despachodepan'
require_relative '../helpers/despachodepan_helpers'
require_relative '../helpers/card_helpers'
Despachodepan.load

require 'test/unit/assertions'
extend Test::Unit::Assertions

class HelperTest
  include CardHelpers
  include DespachodepanHelpers
end

slide = Repo.find('SlideImage', 91)
raise "Timeline position should 14 #{slide.timeline_position}" unless slide.timeline_position == '14'
card = Repo.find('Card', 98)
image = Repo.all('MainImage').find {|i| i.card_id == '98'}
puts card.main_image
raise "Main Slide should be present" unless card.main_image == image
puts "All tests passed"
