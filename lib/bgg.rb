require 'open-uri'
require 'crack'
require 'json'

# NOTE: API documentation can be found at https://boardgamegeek.com/wiki/page/BGG_XML_API2

class Bgg

  URL = "http://www.boardgamegeek.com/xmlapi2/%s"
  TYPES = %w(boardgame boardgameexpansion)

  def self.search(term)
    res = Bgg.new.search(term)
    res['items']['item']
  end

  def self.find(*ids)
    res = Bgg.new.find(ids)
    res['items']
  end

  def search(term)
    get(:search, query: term, type: TYPES.join(','))
  end

  def find(*ids)
    get(:thing, id: ids.flatten.join(','), type: TYPES.join(','))
  end

  protected

  def endpoint(resource, params)
    uri = URI(URL % resource)
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end

  def log(msg)
    puts "-- #{msg}"
  end

  def get(resource, params = {})
    uri = endpoint(resource, params)
    response = open(uri)
    Crack::XML.parse(response.read)
  end

end
