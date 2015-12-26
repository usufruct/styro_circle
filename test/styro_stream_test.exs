defmodule StyroStreamTest do
  use ExUnit.Case
  doctest StyroStream

  test "create_stream with string" do
    stream = StyroStream.create("fubar", 2)
    assert Enum.to_list(stream) == ["fu", "ub", "ba", "ar", "rf", "fu"]

    stream = StyroStream.create("fubar", 3)
    assert Enum.to_list(stream) == ["fub", "uba", "bar", "arf", "rfu", "fub"]
  end
end