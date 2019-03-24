require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'

desc 'Run all tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = %w[--color --warnings]
end

task default: [:spec]
