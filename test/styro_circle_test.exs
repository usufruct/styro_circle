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

  test "frequency_map" do
    {:ok, graph} = StyroCircle.new_graph
    assert StyroCircle.frequency_map(graph)
           |> is_map == true
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

  test "add_edge maintains count of pair occurences" do
    {:ok, graph} = StyroCircle.new_graph
    StyroCircle.add_vertex(graph, :foo, {})
    StyroCircle.add_vertex(graph, :bar, {})
    StyroCircle.add_edge(graph, :foo, :bar, {})

    assert StyroCircle.frequency_map(graph)
           |> HashDict.get({}) == 1

    StyroCircle.add_edge(graph, :foo, :bar, {})
    assert StyroCircle.frequency_map(graph)
           |> HashDict.get({}) == 2
  end
end
