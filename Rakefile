# frozen_string_literal: true

require "rake/testtask"
require "rake/clean"
require "rubocop/rake_task"
require "bundler/gem_tasks"

require_relative "lib/heroicons/heroicon"

CLEAN.include("vendor/**/*")

task :test => :check_assets

RuboCop::RakeTask.new(:lint) do |t|
  t.options = ["--display-cop-names"]
end

Rake::TestTask.new do |t|
  t.libs = ["lib", "test"]
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = false
end

desc "Validate existence of required assets"
task :check_assets do
  warn "Checking existence of assets."
  if not File.exist?(Heroicons::Heroicon::METADATA_PATH)
    warn "Assets are missing. Initiating download..."
    Rake::Task["download"].invoke
  else
    warn "Assets do exist. Continue..."
  end
end

desc "Bump the release version"
task :version, [:v] do |t, args|
  out = "module Heroicons\n"\
    "  VERSION = \"#{args[:v]}\".freeze\n"\
    "end\n"
  File.open(File.expand_path("../lib/heroicons/version.rb", __FILE__), "w") { |file| file.puts out }
end

desc "Run tests"
task default: :test
