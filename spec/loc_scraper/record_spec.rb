require 'spec_helper'
require 'loc_scraper'

describe LocScraper::Record do

  before(:all) do
    @page = Nokogiri::HTML(File.open('spec/fixtures/abrahamlincoln.html', 'r') { |f| f.read })
    @isbn = '9781602530454'
    @record = LocScraper::Record.new(@isbn)
  end

  describe '.get' do
    it 'Create an instance of LocScraper::Record class' do
      expect(@record).to be_instance_of LocScraper::Record
    end
  end

  describe '#search_by_label' do
    it 'returns the tag text associated with label of the record' do
      expect(@record.send(:search_by_label, 'UNKNOWN:')).to eq nil
    end
  end

  describe '#main_title' do
    it 'returns the main title of the record' do
      expect(@record.main_title).to eq 'Abraham Lincoln : our sixteenth president / by Sarah Hansen.'
    end
  end

  describe '#dewey' do
    it 'returns the dewey of the record' do
      expect(@record.dewey).to eq '973.7092 B'
    end
  end

  describe '#lccn' do
    it 'returns the lccn of the record' do
      expect(@record.lccn).to eq '2008001164'
    end
  end

  describe '#lcc' do
    it 'returns the lcc of the record' do
      expect(@record.lcc).to eq 'E457.905 .H285 2009'
    end
  end

  describe '#to_json' do
    it 'returns the json format of the record' do
      @record.to_json
    end
  end

end
