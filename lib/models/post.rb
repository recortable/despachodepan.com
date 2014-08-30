class Post < Pan
end

class Blog
  MIN_WIDTH = 843

  def self.load
    @posts = Repository.load('Posts')
    @posts.sort_by! {|post| "#{post.rev_date}" }
  end

  def self.posts
    @posts ||= []
  end

  def self.width
    width = posts.each.map { |post| post.width.to_i + 10 }.inject { |sum, n| sum + n }
    width = 0 unless width
    width < MIN_WIDTH ? MIN_WIDTH : width
  end
end
