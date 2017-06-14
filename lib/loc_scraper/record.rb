# -*- coding: utf-8 -*-
module LocScraper
  class Record

    USER_AGENTS = ['Windows IE 6', 'Windows IE 7', 'Windows Mozilla', 'Mac Safari', 'Mac Firefox', 'Mac Mozilla', 'Linux Mozilla', 'Linux Firefox', 'Linux Konqueror']

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
      @loc_url = "http://catalog.loc.gov/vwebv/search?searchArg=#{@isbn}&searchCode=GKEY%5E*&searchType=1&limitTo=LOCA%3Dall"
      @page = http_client.get(@loc_url)
      if @page.at("[text()*='Your search found no results']")
        raise ArgumentError, "ISBN not found"
      end
      @page
    end

    def main_title
      return @main_title unless @main_title.nil? || @main_title.empty?
      search_by_label('Main title', tag: 'h3')
    end

    def dewey
      return @dewey unless @dewey.nil? || @dewey.empty?
      search_by_label('Dewey class no.', tag: 'h3')
    end

    def lccn
      return @lccn unless @lccn.nil? || @lccn.empty?
      search_by_label('LCCN', tag: 'h3', allow_nil: false)
    end

    # Returns the library of congress classification
    def lcc
      return @lcc unless @lcc.nil? || @lcc.empty?
      search_by_label('LC classification (full)', tag: 'h3')
    end

    # Returns the summary
    def summary
      return @summary unless @summary.nil? || @summary.empty?
      search_by_label('Summary', tag: 'h3')
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
      # * +:tag+ - Restrict text search to given html tag
      # * +:allow_nil+ - Set to false to raise error when label not found
      def search_by_label(label, options = {})
        options = { allow_nil: true }.merge(options)

        unless el = @page.at("#{options[:tag]}[text()$='#{label}']")
          if options[:allow_nil]
            return nil
          else
            raise StandardError, "Label not found: #{label}"
          end
        end

        el.next_element.text.strip
      end

  end
end
