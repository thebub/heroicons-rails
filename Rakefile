# frozen_string_literal: true

require "rake/testtask"
require "rubocop/rake_task"
require "bundler/gem_tasks"

RuboCop::RakeTask.new(:lint) do |t|
  t.options = ["--display-cop-names"]
end

Rake::TestTask.new do |t|
  t.libs = ["lib", "test"]
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Bump the release version"
task :version, [:v] do |t, args|
  out = "module Heroicons\n"\
    "  VERSION = \"#{args[:v]}\".freeze\n"\
    "end\n"
  File.open(File.expand_path("../lib/heroicons/version.rb", __FILE__), "w") { |file| file.puts out }
end

desc "Run tests"
task :test

task default: %i[]
