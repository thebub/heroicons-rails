# frozen_string_literal: true

require_relative "lib/heroicons/version"

Gem::Specification.new do |spec|
  spec.name = "heroicons-rails"
  spec.version = Heroicons::VERSION
  spec.authors = ["Daniel Bub"]
  spec.email = ["daniel.bub@thebub.net"]

  spec.summary = "Add Tailwindlabs Heroicons to a Rails project."
  spec.description = "Add the full set of Herocicons to a Rails project, similar to tailwindcss-rails does for the associated tailwindcss."
  spec.homepage = "https://github.com/thebub/heroicons-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thebub/heroicons-rails"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end + Dir["{vendor}/**/*"]

  spec.bindir = "bin"
  spec.require_paths = ["lib"]

end
