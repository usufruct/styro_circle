defmodule StyroMarkovUtilsTest do
  use ExUnit.Case
  doctest StyroMarkovUtils

  # test "get_next" do
  #   assert StyroMarkovUtils.get_next == {"b", "fu"}
  # end

  test "index_of_random" do
    counts = [1, 3, 3]

    assert StyroMarkovUtils.index_of_random(counts, 1) == 0
    assert StyroMarkovUtils.index_of_random(counts, 2) == 1
    assert StyroMarkovUtils.index_of_random(counts, 4) == 1
    assert StyroMarkovUtils.index_of_random(counts, 5) == 2
  end
end