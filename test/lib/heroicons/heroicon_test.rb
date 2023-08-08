require_relative "../../test_helper"

describe Heroicons::Heroicon do
  it "fails when the heroicon doesn't exist" do
    icon = heroicon("foobar", 20, "solid")
    assert icon.empty?
  end

  it "initialize accepts a string for an icon" do
    icon = heroicon("x-mark", 20, "solid")
    assert icon
  end
end