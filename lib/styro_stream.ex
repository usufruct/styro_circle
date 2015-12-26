defmodule StyroStream do
  @doc ~S"""
  Builds a stream that emits `size` codepoints with a
  one codepoint shift each time. Stream ends by "wrapping"
  first chunk returned as the last (stream is guaranteed to cycle)
  """
  def create(source, size) do
    Stream.resource(
      fn ->
        source <> String.slice(source, 0, size)
      end,
      fn source ->
        next_chunk = String.slice(source, 0, size)

        case String.length(next_chunk) do
          length when length < size ->
            {:halt, source}
          length when length == size ->
            {[next_chunk], String.slice(source, 1..-1)}
        end
      end,
      fn source -> source end
    )
  end
end