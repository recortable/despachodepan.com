
class Blog
  MIN_WIDTH = 843

  def self.load
    @posts = YAML::load_file(File.join(__dir__, 'data', 'posts.yml'))
    @posts.sort_by {|post| "#{post.rev_date}" }
    puts "Posts: #{@posts.size}"
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
