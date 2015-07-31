require_relative 'boot'

require_relative 'lib/api'
require_relative 'lib/app'

run Rack::Cascade.new [API, App]
