Gem::Specification.new do |s|
  s.name        = 'num4tststatistic2'
  s.version     = '0.3.2'
  s.date        = '2025-11-08'
  s.summary     = "statistical hypothesis verification!"
  s.description = "integration module of num4tststatistic and num4hypothtst"
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "https://github.com/siranovel/num4tststatistic2"
  s.license     = "MIT"
  s.required_ruby_version = ">= 3.0"
  s.files       = ["LICENSE", "Gemfile", "CHANGELOG.md"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.add_development_dependency 'num4tststatistic', "~> 0.3", '>= 0.3.1'
  s.add_development_dependency 'num4hypothtst', "~> 0.2", '>= 0.2.1'
end
