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

VENDOR_ASSET_BASE_PATH = Heroicons::Heroicon::ASSET_BASE_FOLDER
METADATA_PATH = Heroicons::Heroicon::METADATA_PATH

# prepend the download task before the Gem::PackageTask tasks
task :package => :download
task :download => :clean

desc "Prepare the gem assets"
task "gem:ruby" => [gem_path]

desc "Download all herocion files"
task "download" do
  warn "Downloading heroicons from #{HEROICONS_RAILS_DOWNLOAD_URL} ..."

  URI.open(HEROICONS_RAILS_DOWNLOAD_URL) do |remote|

    warn "Download completed!\n"

    # Create temp asset folder
    FileUtils.mkdir_p(VENDOR_ASSET_BASE_PATH)

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

          FileUtils.mkdir_p(VENDOR_ASSET_BASE_PATH + File.dirname(entry.name).delete_prefix(zip_src_base_path))

          # TODO: Add sanity checks, matching metadata with SVG attributes
          # TODO: Clean SVG of unwanted attributes
          #doc = Nokogiri::HTML::DocumentFragment.parse(entry.get_input_stream.read)
          #element = doc.at_css 'svg'

          iconpath = VENDOR_ASSET_BASE_PATH + entry.name.delete_prefix(zip_src_base_path)

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
    File.open(METADATA_PATH, "wb") do |f|
      content = {
        "version": Heroicons::Upstream::VERSION,
        "icons": icon_metadata
      }

      f.write(content.to_json)
    end

    warn "Download task completed."

  end
end
