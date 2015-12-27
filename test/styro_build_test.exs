defmodule StyroBuildTest  do
  use ExUnit.Case
  doctest StyroBuild

  test "build_graph" do
    graph = StyroBuild.build_graph "fubar", 2
    assert is_pid graph
  end

  test "populate_graph" do
    graph = StyroBuild.build_graph "fubarfucat", 2

    assert StyroCircle.digraph(graph)
    |> :digraph.out_neighbours("fu")
    |> length == 2

    assert StyroCircle.digraph(graph)
    |> :digraph.out_neighbours("ba")
    |> length == 1
  end
end