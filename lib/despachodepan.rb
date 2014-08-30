require 'yaml'
require_relative 'models/pan'
require_relative 'models/color'
require_relative 'models/card'
require_relative 'models/post'
require_relative 'models/selection'
require_relative 'models/tag'

require_relative 'view_models/process_view'
require_relative 'view_models/selection_view'

module Repository
  def self.load(name)
    data = YAML::load_file(File.join(__dir__, 'data', "#{name.downcase}.yml"))
    puts "#{name}: #{data.size} loaded."
    data
  end

  def self.index_by_id(collection)
    Hash[collection.map {|model| [model.id.to_i, model] }]
  end
end

module Despachodepan
  def self.load
    Colors.load
    Cards.load
    Blog.load
    Selections.load
    Tags.load
    puts "Despachodepan loaded."
  end
end
