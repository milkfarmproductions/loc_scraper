Loc Scraper
================

LocScraper is a gem for scraping Loc catalog pages.
Given the ISBN of the book, it gets the title, dewey, etc.

This code is based largely on LinkedIn Scraper, a gem developed by 
Yatish Mehta. Please see his github project for more information:

https://github.com/yatish27/linkedin-scraper

Thanks to him and other contributors for the foundation of this project.


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
