require "rubygems/package_task"

HEROICONS_RAILS_GEMSPEC = Bundler.load_gemspec("heroicons-rails.gemspec")

gem_path = Gem::PackageTask.new(HEROICONS_RAILS_GEMSPEC).define

desc "Prepare the gem assets"
task "gem:ruby" => [gem_path]
