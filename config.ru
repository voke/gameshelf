require_relative 'app'
run Rack::Cascade.new [API, Web]
