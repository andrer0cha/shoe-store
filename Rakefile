require 'rubocop'
require 'rubocop/rake_task'
require 'rubocop-rake'

task default: %w[lint test]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

task :setup do
  ruby 'db/setup.rb'
  ruby 'db/seed.rb'
end

task :run do
end

task :test do
  ruby 'test/shoe_store_test.rb'
end