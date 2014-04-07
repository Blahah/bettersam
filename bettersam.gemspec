Gem::Specification.new do |s|
  s.name        = 'bettersam'
  s.version     = '0.0.2'
  s.date        = 2014-3-7
  s.license     = 'MIT'
  s.summary     = "Extended SAM file parsing"
  s.description = "Extended SAM (Sequence Alignment/Map) file parsing"
  s.authors     = ["Richard Smith", "Jesse Rodriguez"]
  s.email       = 'rds45@cam.ac.uk'
  s.files       = ["lib/bettersam.rb"]
  s.homepage    = 'https://github.com/blahah/bettersam'

  gem.files = Dir['Rakefile', '{lib,test}/**/*', 'README*', 'LICENSE*']
  gem.require_paths = %w[ lib ]

  gem.add_development_dependency 'rake', '~> 10.1.0'
  gem.add_development_dependency 'turn'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'shoulda-context'
  gem.add_development_dependency 'coveralls', '~> 0.6.7'
end
