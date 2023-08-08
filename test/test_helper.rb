require "minitest/autorun"
require "heroicons"

def heroicon(symbol, size, type)
  ::Heroicons::Heroicon.get_heroicon(symbol, size, type)
end