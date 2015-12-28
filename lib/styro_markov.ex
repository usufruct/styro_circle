defmodule StyroMarkov do
  def new(graph, start) do
    Stream.resource(
      fn -> {graph, start} end,
      fn ({graph, current}) ->
        digraph = StyroCircle.digraph(graph)
        frequency_map = StyroCircle.frequency_map(graph)

        out_edges = :digraph.out_edges(digraph, current)
        total_range = Enum.reduce(out_edges, 0, fn edge, acc ->
          {_, _, _, label} = :digraph.edge(digraph, edge)
          acc + HashDict.get(frequency_map, label)
        end)
        random_index = :rand.uniform(total_range)

        edge_index = Enum.map(out_edges, fn edge ->
                              {_, _, _, label} = :digraph.edge(digraph, edge)
                              label
                            end)
            |> Enum.map(fn label ->
                          HashDict.get(frequency_map, label)
                        end)
            |> StyroMarkovUtils.index_of_random(random_index)

        target_edge = Enum.at(out_edges, edge_index)

        {_, _, next, _} = :digraph.edge(digraph, target_edge)

        String.last(next)

        {[String.last(next)], {graph, next}}
      end,
      fn source ->
        source
      end
    )
  end
end

defmodule StyroMarkovUtils do
  # def get_next do
  #   {"b", "fu"}
  # end

  def index_of_random(counts, count_point) do
    index_of_random(counts, count_point, 0)
  end

  defp index_of_random([count | counts], count_point, index) do
    case count_point - count do
      match_point when match_point > 0 ->
        index_of_random(counts, match_point, index + 1)
      _ ->
        index
    end
  end
end