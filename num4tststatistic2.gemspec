Gem::Specification.new do |s|
  s.name        = 'num4tststatistic2'
  s.version     = '0.2.1'
  s.date        = '2024-05-15'
  s.summary     = "statistical hypothesis verification!"
  s.description = "integration module of num4tststatistic and num4hypothtst"
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "https://github.com/siranovel/num4tststatistic2"
  s.license     = "MIT"
  s.files       = ["LICENSE", "Gemfile", "CHANGELOG.md"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.add_development_dependency 'num4tststatistic', '~> 0.2', '>= 0.2.2'
  s.add_development_dependency 'num4hypothtst', '~> 0.1', '>= 0.1.1'
end
