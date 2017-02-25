defmodule HuffmanCoding do
  @moduledoc """
  Documentation for HuffmanCoding.
  """

  def frequency(""), do: %{}

  def frequency(sentence) do
    frequency = sentence
      |> String.upcase
      |> String.graphemes
      |> Enum.filter(fn c -> c =~ ~r/[A-Z]/ end)
      |> Enum.reduce(Map.new, fn c,acc -> Map.update(acc, c, 1, &(&1+1)) end)
      |> Enum.sort_by(fn {_k,v} -> -v end)
    frequency
  end


  defp balance_heap(heap, new_item, index) do
    parent_index = round Float.floor(index/2)
    try do
      parent = elem(heap, parent_index)
      case elem(parent, 1) > elem(new_item, 1)  do
        true ->
                Tuple.delete_at(heap, parent_index) |>
                  Tuple.insert_at(parent_index, new_item) |>
                    Tuple.delete_at(index) |>
                      Tuple.insert_at(index, parent) |>
                        balance_heap(new_item, parent_index)
        false -> heap
      end
    rescue
      _ -> heap
    end
  end

  def heapify(freqlist, heap \\ {}, index \\ 0)

  def heapify([], heap , _index), do: heap

  def heapify([head | tail], heap , index) do
    case heap == {} do
      true -> heapify(tail, {head}, index + 1)
      _    -> heap = balance_heap(Tuple.append(heap, head), head, index)
              heapify(tail, heap, index + 1)
    end

  end
end
