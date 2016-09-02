Loc Scraper
================

[![Build Status](https://travis-ci.org/milkfarm/loc_scraper.svg?branch=master)](https://travis-ci.org/milkfarm/loc_scraper)

LocScraper is a gem for scraping Loc catalog pages.
Given the ISBN of the book, it gets the title, dewey, etc.

##Installation

Install the gem from RubyGems:

    gem install loc_scraper

This gem is tested on 1.9.3


##Usage

Initialize a scraper instance

    record = LocScraper::Record.get("9781609543914")

The returning object responds to the following methods

    record.name          # The name of the book

    record.dewey         # The dewey of the book


## Special Thanks

This code is derived from [LinkedIn Scraper](https://github.com/yatish27/linkedin-scraper), a gem developed by Yatish Mehta.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
