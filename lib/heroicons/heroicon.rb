module Heroicons
  module Heroicon
    DEFAULT_HEIGHT = 16

    ASSET_BASE_FOLDER = "vendor/assets/heroicons/"
    METADATA_PATH = ASSET_BASE_FOLDER + "data.json"

    @@cache = {}

    module_function

    def get_heroicon(symbol, size, type)
      return "" if symbol.nil?

      cache_key = [symbol, size, type]

      if icon = @@cache[cache_key] then
        icon
      else
        icon_path = File.join(ASSET_BASE_FOLDER, size.to_s, type, "#{symbol}.svg")

        if File.exist? icon_path then
          icon = File.open(icon_path, "r").read

          @@cache[cache_key] = icon
          icon
        else
          ""
        end
      end
    end
  end
end
