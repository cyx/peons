desc "Run all tests"
task :test do
  require "cutest"

  Cutest.run(Dir["test/*_test.rb"])
end
task :default => :test
