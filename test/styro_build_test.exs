defmodule StyroBuildTest  do
  use ExUnit.Case
  doctest StyroBuild

  test "build_graph" do
    graph = StyroBuild.build_graph
    assert is_pid graph
  end
end