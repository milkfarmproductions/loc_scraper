# -*- encoding: utf-8 -*-
require File.expand_path('../lib/loc_scraper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Tim Peterson']
  gem.description   = %q{Scrape the loc record associated with a given ISBN}
  gem.summary       = %q{Given an ISBN, scrape the Loc record and convert into an accessible object}
  gem.homepage      = 'https://github.com/milkfarm/loc_scraper'
  gem.files         = `git ls-files`.split($\)
  gem.executables   = ['loc_scraper']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'loc_scraper'
  gem.require_paths = ['lib']
  gem.version       = LocScraper::VERSION

  gem.add_dependency(%q<mechanize>, ['>= 0'])

  gem.add_development_dependency 'rspec', '>=0'
  gem.add_development_dependency 'rake'

end
