defmodule StyroCircleTest do
  use ExUnit.Case
  doctest StyroCircle

  test "new_graph" do
    {:ok, graph} = StyroCircle.new_graph
    assert is_pid graph
  end

  test "digraph" do
    {:ok, graph} = StyroCircle.new_graph
    assert StyroCircle.digraph(graph)
           |> :digraph.no_edges == 0
  end

  test "add_vertex" do
    {:ok, graph} = StyroCircle.new_graph
    StyroCircle.add_vertex(graph, :foo, {})
    StyroCircle.add_vertex(graph, :bar, {})
    assert StyroCircle.digraph(graph)
           |> :digraph.no_vertices == 2
  end

  test "add_edge" do
    {:ok, graph} = StyroCircle.new_graph
    StyroCircle.add_vertex(graph, :foo, {})
    StyroCircle.add_vertex(graph, :bar, {})
    StyroCircle.add_edge(graph, :foo, :bar, {})
    assert StyroCircle.digraph(graph)
           |> :digraph.no_edges == 1
  end
end
