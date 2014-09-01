module BlogHelpers
  MIN_WIDTH = 843

  def blog_width(posts)
    width = posts.each.map { |post| post.width.to_i + 10 }.inject { |sum, n| sum + n }
    width = 0 unless width
    width < MIN_WIDTH ? MIN_WIDTH : width
  end
end
