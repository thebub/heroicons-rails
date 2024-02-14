require "rails"

module Heroicons
  class Heroicons < Rails::Railtie
    initializer "heroicons.heroicon" do
      ActionView::Base.send :include, Heroicon
    end
  end
end
