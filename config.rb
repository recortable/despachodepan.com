require 'lib/despachodepan'
Despachodepan.load

# require "helpers/html_helpers"
# helpers HtmlHelpers
# require "helpers/markdown_helpers"
# helpers MarkdownHelpers
# require "lib/helpers/despachodepan_helpers"
# helpers DespachodepanHelpers


set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
