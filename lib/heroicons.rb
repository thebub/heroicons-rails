require "heroicons/version"
require "heroicons/heroicon"
require "json"

module Heroicons
  file_data = File.read(File.join(File.dirname(__FILE__), "../", Heroicon::ASSET_BASE_FOLDER, "data.json"))
  HEROICONS_SYMBOLS = JSON.parse(file_data).freeze
end