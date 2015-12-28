defmodule StyroMarkovTest do
  use ExUnit.Case
  doctest StyroMarkov

  test "new" do
    graph = StyroBuild.build_graph "fubar", 2
    markov_stream = StyroMarkov.new(graph, "fu")

    assert Enum.take(markov_stream, 1) == ["b"]
    assert Enum.take(markov_stream, 3) == ["b", "a", "r"]
    assert Enum.take(markov_stream, 5) == ["b", "a", "r", "f", "u"]

    markov_stream = StyroMarkov.new(graph, "ba")

    assert Enum.take(markov_stream, 1) == ["r"]
    assert Enum.take(markov_stream, 3) == ["r", "f", "u"]
    assert Enum.take(markov_stream, 5) == ["r", "f", "u", "b", "a"]
  end
end