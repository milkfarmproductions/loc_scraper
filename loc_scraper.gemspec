# -*- encoding: utf-8 -*-
require File.expand_path('../lib/loc_scraper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'loc_scraper'
  gem.version       = LocScraper::VERSION
  gem.authors       = ['milkfarm productions']
  gem.email         = ['stuff@milkfarmproductions.com']
  gem.description   = %q{Scrape the loc record associated with a given ISBN}
  gem.summary       = %q{Given an ISBN, scrape the Loc record and convert into an accessible object}
  gem.license       = 'MIT'
  gem.homepage      = 'http://github.com/milkfarm/loc_scraper'
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'mechanize', '~> 2.7'
  gem.add_dependency 'mime-types', '~> 1.25'

  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake', '~> 10'
  gem.add_development_dependency 'rspec', '~> 3'

end
