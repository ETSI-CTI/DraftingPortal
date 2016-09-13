# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Make public assets requireable in manifest files
[
  Rails.root.join("public", "assets", "stylesheets"),
  Rails.root.join("public", "assets", "javascripts")
].each do |path|
  Rails.application.config.assets.paths << path
end

rev_manifest_path = 'public/assets/rev-manifest.json'

if File.exist?(rev_manifest_path)
  REV_MANIFEST = JSON.parse(File.read(rev_manifest_path))
end
