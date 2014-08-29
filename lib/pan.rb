AmazonFile = Struct.new(:name, :prefix, :id) do
  def url
    "https://depan.s3.amazonaws.com/#{prefix.downcase}/file/#{id}/#{name}"
  end
end

Pan = Struct.new(:id, :type, :card_id, :text, :position,
  :date, :body, :rev_date, :content_type, :size, :width, :height, :file,
  :original_id, :created_at, :updated_at, :settings) do

    def card
      Cards.find(card_id)
    end

    def upfile
      @file ||= AmazonFile.new(file, self.class.to_s, id)
    end
end

class Post < Pan
end
