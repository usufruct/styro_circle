defmodule StyroCircle do
  def new_graph do
    Agent.start_link(fn ->
      :digraph.new()
    end)
  end

  def digraph(graph) do
    Agent.get(graph, fn digraph ->
      digraph
    end)
  end

  def add_vertex(graph, vertex, label) do
    Agent.update(graph, fn digraph ->
      :digraph.add_vertex(digraph, vertex, label)
      digraph
    end)
  end

  def add_edge(graph, vertex1, vertex2, label) do
    Agent.update(graph, fn digraph ->
      :digraph.add_edge(digraph, vertex1, vertex2, label)
      digraph
    end)
  end
end
