require 'yaml'
require_relative '../lib/despachodepan'

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
    pans = {}
    table.each do |row|
      type = row[1]
      pans[type] ||= []
      model = Object.const_get(type).new(*row)
      pans[type] << model
    end

    pans.each_key do |key|
      save_table(key, pans[key])
    end
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
