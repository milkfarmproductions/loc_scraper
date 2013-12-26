Loc Scraper
================

LocScraper is a gem for scraping Loc catalog pages.
Given the ISBN of the book, it gets the name, dewey, etc.


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
