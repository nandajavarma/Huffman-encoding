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


  defp balance(heap, index) do
    parent = elem(heap, index)
    try do
      lchild = elem(heap, 2*index)
      rchild = elem(heap, 2*index + 1)
      small_pos =
        case elem(lchild, 1) > elem(rchild, 1) do
          true -> 2*index + 1
          _ ->  2*index
        end
      case elem(lchild, 1) <= elem(parent, 1) or elem(rchild, 1) <= elem(parent, 1) do
        true -> put_elem(heap, index, elem(heap, small_pos)) |>
                  put_elem(small_pos, parent) |>
                    balance(small_pos)
        false -> heap
      end
    rescue
      _ -> heap
    end
  end

  def remove_from_heap({}), do: {{}, nil}

  def remove_from_heap(heap) do
    tsize = tuple_size(heap)
    {min, new_heap} =
          case tsize do
            1 -> {elem(heap, 0), {}}
            2 -> first = elem(heap, 0)
                 second = elem(heap, 1)
                 case elem(first, 1) > elem(second, 1) do
                   true -> {second, Tuple.delete_at(heap, 1)}
                   _ -> {first, Tuple.delete_at(heap, 0)}
                 end
            _ ->
                  rep = elem(heap, tsize - 1)
                  {elem(heap, 1),
                      Tuple.delete_at(heap, tsize - 1) |>
                            put_elem(1, rep) |>
                              balance(1)}
          end
    {new_heap, min}
  end

  defp insert_into_heap(heap, new_item, index) do
    parent_index = round Float.floor(index/2)
    try do
      parent = elem(heap, parent_index)
      case elem(parent, 1) > elem(new_item, 1)  do
        true ->
                Tuple.delete_at(heap, parent_index) |>
                  Tuple.insert_at(parent_index, new_item) |>
                    Tuple.delete_at(index) |>
                      Tuple.insert_at(index, parent) |>
                        insert_into_heap(new_item, parent_index)
        false -> heap
      end
    rescue
      _ -> heap
    end
  end

  def heapify(freqlist, heap \\ {}, index \\ 0)

  def heapify([], heap , _index), do: Tuple.insert_at(heap, 0, {0, 0})

  def heapify([head | tail], heap , index) do
    case heap == {} do
      true -> heapify(tail, {head}, index + 1)
      _    -> heap = insert_into_heap(Tuple.append(heap, head), head, index)
              heapify(tail, heap, index + 1)
    end
  end

  def create_huffman_tree(hmap, {}), do: hmap

  def create_huffman_tree(hmap, heap) do
    {new_heap, min} = remove_from_heap(heap)
    if new_heap == {} do
      new_val = hmap['val'] + elem(min, 1)
      create_huffman_tree(%{'val' => new_val, 'right' => hmap, 'left' => min}, new_heap)
    else
      create_huffman_tree(hmap, new_heap)
    end
  end

  def create_huffman_tree(heap) do
    {new_leaf, heap} = create_leaf_node(heap)
    create_huffman_tree(new_leaf, heap)
  end

  def create_leaf_node(heap) do
    {new_heap, min1} = remove_from_heap(heap)
    {new_heap, min2} = remove_from_heap(new_heap)
    new_val = elem(min1, 1) + elem(min2, 1)
    {%{'val' => new_val, 'left' => min1, 'right' => min2}, Tuple.delete_at(new_heap, 0)}
  end

end
