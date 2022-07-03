task default: %w[test]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

task :run do
  ruby 'lib/shoe_store.rb'
end

task :test do
  ruby 'test/shoe_store_test.rb'
end