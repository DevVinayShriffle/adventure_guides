require 'nokogiri'
require 'pry'
require 'open-uri'

class Scrapper
  def self.call(url)
    new(url).call
  end

  def initialize(url)
    @url = url
  end

  def call
    html = URI.open(@url)
    doc = Nokogiri::HTML(html)
    destinations = doc.css('#destination-card').css('a')

    destination_urls = []

    destinations.each do |destination|
      url = destination.attribute('href').value
      destination_urls << url
    end
    # puts destination_urls
    scrape_destination_urls(destination_urls)
  end

  def scrape_destination_urls(destination_urls)
    destination_urls.each do |destination|
      doc = Nokogiri::HTML(URI.open("http://127.0.0.1:3000#{destination}"))

      buses = doc.css('#dest-bus').css('a')

      bus_urls = []
      buses.each do |bus|
        url = bus.attribute('href').value
        bus_urls << url
      end
      puts bus_urls
      # binding.pry
    end
  end
end

Scrapper.call('http://127.0.0.1:3000/destinations')