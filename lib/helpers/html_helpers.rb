module HtmlHelpers
  def current_page?(path)
    current_page.url == path
  end

  def link_to_if(condition, name, options = {}, html_options = {}, &block)
    condition ? link_to(name, options, html_options) : name
  end
end
