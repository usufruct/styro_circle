defmodule StyroBuild do
  def build_graph(source, size) do
    {:ok, graph} = StyroCircle.new_graph
    graph_source = StyroStream.create(source, size)

    populate_graph(graph_source, graph)
  end

  defp populate_graph(graph_source, graph) do
    Enum.each(Stream.chunk(graph_source, 2, 1), fn([first_combo, second_combo]) ->
      StyroCircle.add_vertex(graph, first_combo, {})
      StyroCircle.add_vertex(graph, second_combo, {})
      StyroCircle.add_edge(graph, first_combo, second_combo, { first_combo <> second_combo })
    end)

    graph
  end
end