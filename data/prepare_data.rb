require 'yaml'
require_relative '../lib/models/card.rb'
require_relative '../lib/models/color.rb'
require_relative '../lib/models/pan.rb'
require_relative '../lib/models/post.rb'
require_relative '../lib/models/selection.rb'
require_relative '../lib/models/tag.rb'

class PrepareData
  def initialize
    YAML::load_documents(File.new(File.join(__dir__, 'data.yml'), 'r')) do |doc|
      table = doc.keys.first
      send("prepare_#{table}", doc[table]['columns'], doc[table]['records'])
    end
  end

  def prepare_tags(columns, table)
    prepare_model(Tag, table)
  end

  def prepare_cards(columns, table)
    prepare_model(Card, table)
  end

  def prepare_cards_tags(columns, table)
    prepare_model(CardTag, table)
  end

  def prepare_colors(columns, table)
    prepare_model(Color, table)
  end

  def prepare_pans(columns, table)
    @posts = []
    @selections = []
    table.each do |row|
      @posts << Post.new(*row) if row[1] == 'Post'
      @selections << Selection.new(*row) if row[1] == 'Selection'
    end
    save_table('Post', @posts)
    save_table('Selection', @selections)
  end

  def prepare_model(clazz, data)
    models = []
    data.each {|row| models << clazz.new(*row) }
    save_table(clazz.to_s, models)
  end

  def save_table(name, data)
    open("lib/data/#{name.downcase}s.yml", 'w') {|f| YAML.dump(data, f)}
    puts "#{name}: #{data.size} saved."
  end
end

PrepareData.new
