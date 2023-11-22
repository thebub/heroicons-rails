require_relative "../../test_helper"

describe Heroicons do
  it "loads all icon metadata on initialization" do
    refute_equal 0, Heroicons::HEROICONS_SYMBOLS.length
    any_icon = Heroicons::HEROICONS_SYMBOLS[0]
    assert any_icon["name"]
    assert any_icon["type"]
    assert any_icon["size"]
    assert any_icon["path"]
  end
end