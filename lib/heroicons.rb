require "heroicons/upstream"
require "heroicons/heroicon"
require "heroicons/railtie" if defined?(Rails)
require "json"

module Heroicons
  file_data = File.read(File.join(File.dirname(__FILE__), "../", Heroicon::METADATA_PATH))
  metadata = JSON.parse(file_data)

  HEROICONS_VERSION = metadata["version"].freeze
  HEROICONS_SYMBOLS = metadata["icons"].freeze
end
