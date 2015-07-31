require 'excon'
require 'crack'
require 'json'

# NOTE: API documentation can be found at https://boardgamegeek.com/wiki/page/BGG_XML_API2

class Bgg

  URL = "http://www.boardgamegeek.com/xmlapi2/%s"
  TYPES = %w(boardgame boardgameexpansion)

  RequestNotComplete = Class.new(StandardError)
  MAX_RETRIES = 3

  def initialize(debug = false)
    @debug = debug
  end

  def get_collection(username)
    retry_count = 0
    begin
      res = get_raw(:collection, username: username, own: 1, brief: 1)
      raise RequestNotComplete if res.status == 202
      parse(res.body)['items']['item']
    rescue RequestNotComplete
      retry_count += 1
      if retry_count < MAX_RETRIES
        puts "Retry (#{retry_count})"
        sleep retry_count*2
        retry
      end
    end
  end

  def search(term)
    res = get(:search, query: term, type: TYPES.join(','))
    res['items']['item']
  end

  def find(*ids)
    res = get(:thing, id: ids.flatten.join(','), type: TYPES.join(','))
    res['items']['item']
  end

  protected

  def endpoint(resource, params)
    uri = URI(URL % resource)
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end

  def log(msg)
    puts "-- #{msg}" if @debug
  end

  def get_raw(resource, params = {})
    uri = endpoint(resource, params)
    log("GET: #{uri}")
    response = Excon.get(uri)
  end

  def parse(body)
    Crack::XML.parse(body)
  end

  def get(resource, params = {})
    response = get_raw(resource, params)
    parse(response.body)
  end

end
