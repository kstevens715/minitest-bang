Gem::Specification.new do |s|
  s.name = "minitest-spec-let-bang"
  s.version = "0.0.2"
  s.date = "2014-07-23"
  s.summary = "Bang!"
  s.description = "Lets you use let! to immediately execute lets in minitest spec"
  s.authors = ["Kyle Stevens", "Ben Kanouse", "Rob Jones"]
  s.email = "kstevens715@gmail.com"
  s.files = ["lib/let_bang.rb"]
  s.homepage = "http://rubygems.org/gems/minitest-spec-let-bang"
  s.license = "MIT"
  s.add_development_dependency "minitest", ["~> 5.4.0"]
end
