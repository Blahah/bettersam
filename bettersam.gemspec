Gem::Specification.new do |gem|
  gem.name        = 'bettersam'
  gem.version     = '0.1.0'
  gem.date        = '2014-08-05'
  gem.license     = 'MIT'
  gem.summary     = "Extended SAM file parsing"
  gem.description = "Extended SAM (Sequence Alignment/Map) file parsing"
  gem.authors     = ["Richard Smith-Unna", "Chris Boursnell", "Jesse Rodriguez"]
  gem.email       = 'rds45@cam.ac.uk'
  gem.files       = ["lib/bettersam.rb"]
  gem.homepage    = 'https://github.com/blahah/bettersam'

  gem.files = Dir['Rakefile', '{lib,test}/**/*', 'README*', 'LICENSE*']
  gem.require_paths = %w[ lib ]

  gem.add_development_dependency 'simplecov', '~> 0.8', '>= 0.8.2'
  gem.add_development_dependency 'rake', '~> 10.3', '>= 10.3.2'
  gem.add_development_dependency 'turn', '~> 0.9', '>= 0.9.7'
  gem.add_development_dependency 'shoulda-context', '~> 1.2', '>= 1.2.1'
  gem.add_development_dependency 'coveralls', '~> 0.7'
end
