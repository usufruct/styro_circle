defmodule StyroCircle do
  def new_graph do
    Agent.start_link(fn ->
      {:digraph.new(), HashDict.new}
    end)
  end

  def digraph(graph) do
    Agent.get(graph, fn store ->
      elem(store, 0)
    end)
  end

  def frequency_map(graph) do
    Agent.get(graph, fn store ->
      elem(store, 1)
    end)
  end

  def add_vertex(graph, vertex, label) do
    Agent.update(graph, fn store ->
      digraph = elem(store, 0)
      :digraph.add_vertex(digraph, vertex, label)
      store
    end)
  end

  def add_edge(graph, vertex1, vertex2, label) do
    Agent.update(graph, fn store ->
      digraph = elem(store, 0)
      frequency_map = elem(store, 1)

      link_count = HashDict.get(frequency_map, label) || 0

      :digraph.add_edge(digraph, vertex1, vertex2, label)
      frequency_map = HashDict.put(frequency_map, label, link_count + 1)

      put_elem(store, 1, frequency_map)
    end)
  end
end
