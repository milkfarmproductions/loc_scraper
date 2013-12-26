# -*- coding: utf-8 -*-
module LocScraper
  class Record

    USER_AGENTS = ['Windows IE 6', 'Windows IE 7', 'Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla', 'Linux Firefox', 'Linux Konqueror']

    ATTRIBUTES = %w(main_title dewey lccn lcc summary)

    attr_reader :page, :isbn, :loc_url

    def self.get(isbn)
      begin
        LocScraper::Record.new(isbn)
      rescue => e
        puts e
      end
    end

    def initialize(isbn)
      @isbn = isbn.to_s.strip.gsub(/[-_'."]/, '')
      if @isbn.nil? || @isbn.empty?
        raise ArgumentError, "ISBN cannot be blank"
      end
      @loc_url = "http://catalog.loc.gov/cgi-bin/Pwebrecon.cgi?v3=1&Search%5FArg=#{@isbn}&Search%5FCode=STNO&CNT=1&SID=1"
      @page = http_client.get(@loc_url)
      if @page.at("[text()*='Your search found no results']")
        raise ArgumentError, "ISBN not found"
      end
      @page
    end

    def main_title
      return @main_title unless @main_title.nil? || @main_title.empty?
      search_by_label('Main title:')
    end

    def dewey
      return @dewey unless @dewey.nil? || @dewey.empty?
      search_by_label('Dewey class no.:')
    end

    def lccn
      return @lccn unless @lccn.nil? || @lccn.empty?
      search_by_label('LC control no.:', allow_nil: false)
    end

    # Returns the library of congress classification
    def lcc
      return @lcc unless @lcc.nil? || @lcc.empty?
      search_by_label('LC classification:')
    end

    # Returns the summary
    def summary
      return @summary unless @summary.nil? || @summary.empty?
      search_by_label('Summary:')
    end

    def to_json
      require 'json'
      ATTRIBUTES.reduce({}){ |hash,attr| hash[attr.to_sym] = self.send(attr.to_sym);hash }.to_json
    end

    private

      def http_client
        Mechanize.new do |agent|
          agent.user_agent_alias = USER_AGENTS.sample
          agent.max_history = 0
        end
      end

      # Returns the text of the next element after the one containing
      # the given label.
      #
      # Options:
      # * +:allow_nil+ - Set to false to raise error when label not found
      def search_by_label(label, options = {})
        options = { allow_nil: true }.merge(options)

        unless el = @page.at("th[text()*='#{label}']")
          if options[:allow_nil]
            return nil
          else
            raise StandardError, "Label not found"
          end
        end

        el.next_element.text.strip
      end

  end
end
