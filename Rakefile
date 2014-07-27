require "rake/testtask"

task default: "test:all"

namespace :test do

  desc "Run all tests"
  Rake::TestTask.new(:all) do |t|
    t.test_files = FileList['test/*test.rb']
    t.verbose=true
  end

end
