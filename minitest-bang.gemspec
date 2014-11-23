Gem::Specification.new do |s|
  s.name = "minitest-bang"
  s.version = "0.1.2"
  s.date = "2014-07-24"
  s.summary = "Provides let! for minitest spec, much like RSpec's."
  s.description = "Lets you use let! to immediately execute lets in minitest spec."
  s.authors = ["Kyle Stevens", "Ben Kanouse", "Rob Jones"]
  s.email = "kstevens715@gmail.com"
  s.files = ["lib/minitest/bang.rb"]
  s.homepage = "https://github.com/kstevens715/minitest-bang"
  s.license = "MIT"
  s.add_development_dependency "rake"
  s.add_development_dependency "coveralls"
  s.add_runtime_dependency "minitest", ">= 4.7.5", '<= 5.4.3'
end
