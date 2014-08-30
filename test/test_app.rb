require_relative '../lib/despachodepan'
require_relative '../lib/helpers/despachodepan_helpers'
Despachodepan.load

class HelperTest
  include DespachodepanHelpers
end

helper = HelperTest.new
card = Cards.all.first
helper.pinta_card(card)
