require 'lib/despachodepan'
Despachodepan.load

# require "helpers/html_helpers"
# helpers HtmlHelpers
# require "helpers/markdown_helpers"
# helpers MarkdownHelpers
# require "lib/helpers/despachodepan_helpers"
# helpers DespachodepanHelpers

Repo.all('Card').each do |card|
  proxy "/#{card.title.parameterize}", "/card.html",
    locals: { card: card}, ignore: true
end

Repo.all('SlideImage').each do |slide|
  proxy "/thumb/#{slide.id}", "/thumb.html",
    locals: { slide: slide}, ignore: true
end


set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end


activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'liki.es'
  deploy.path   = '/home/deployer/despachodepan.com'
  deploy.user  = 'deployer' # no default
  # deploy.port  = 5309 # ssh port, default: 22
  # deploy.clean = true # remove orphaned files on remote host, default: false
  # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
end
