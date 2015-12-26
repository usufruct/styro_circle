defmodule StyroBuild do
  def build_graph() do
    {:ok, graph} = StyroCircle.new_graph
    graph
  end
end