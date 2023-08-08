require "rubygems/package_task"
require "open-uri"
require "fileutils"
require "zip"
require "nokogiri"
require "json"

require_relative "../lib/heroicons/upstream"
require_relative "../lib/heroicons/heroicon"

HEROICONS_RAILS_DOWNLOAD_URL = "https://github.com/tailwindlabs/heroicons/archive/refs/tags/v#{Heroicons::Upstream::VERSION}.zip"

HEROICONS_RAILS_GEMSPEC = Bundler.load_gemspec("heroicons-rails.gemspec")

gem_path = Gem::PackageTask.new(HEROICONS_RAILS_GEMSPEC).define
desc "Build the ruby gem"
task "gem:ruby" => [gem_path]

warn "Downloading heroicons from #{HEROICONS_RAILS_DOWNLOAD_URL} ..."

URI.open(HEROICONS_RAILS_DOWNLOAD_URL) do |remote|

  warn "Download completed!\n"

  vendor_asset_base_path = Heroicons::Heroicon::ASSET_BASE_FOLDER

  # Clear existing temp asset folder
  File.exist?(vendor_asset_base_path) ? FileUtils.remove_dir(vendor_asset_base_path) : nil

  # Create temp asset folder
  FileUtils.mkdir_p(vendor_asset_base_path)

  zip_src_base_path = "heroicons-#{Heroicons::Upstream::VERSION}/optimized/"
  
  icon_metadata = []

  Zip::File.open_buffer(remote.read) do |zip|
    zip.each do |entry|

      if File.dirname(entry.name).start_with?(zip_src_base_path) && File.extname(entry.name) == ".svg"
        matches = entry.name.match /(.+)\/(.+)\/(.+)\/(([^\/]+)(.svg))/
        
        name = matches[5]
        type = matches[3]
        size = matches[2]

        warn "Processing icon: #{name} (size: #{size}, type: #{type})"

        FileUtils.mkdir_p(vendor_asset_base_path + File.dirname(entry.name).delete_prefix(zip_src_base_path))

        # TODO: Add sanity checks, matching metadata with SVG attributes
        # TODO: Clean SVG of unwanted attributes
        #doc = Nokogiri::HTML::DocumentFragment.parse(entry.get_input_stream.read)
        #element = doc.at_css 'svg'

        iconpath = vendor_asset_base_path + entry.name.delete_prefix(zip_src_base_path) 

        File.open(iconpath, "wb") do |local|
          local.write(entry.get_input_stream.read)
        end

        icon_metadata.push({
          "name": name,
          "type": type,
          "size": size,
          "path": iconpath
        })
      end
    end
  end  

  warn "Writing metadata file..."
  File.open(vendor_asset_base_path + "data.json", "wb") do |f|
    f.write(icon_metadata.to_json)
  end

  warn "Package task completed."

end