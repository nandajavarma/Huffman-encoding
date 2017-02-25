defmodule HuffmanCodingTest do
  use ExUnit.Case
  doctest HuffmanCoding

  @string "hip hip hurray"
  @frequency_list [{"H", 3}, {"I", 2}, {"P", 2}, {"R", 2}, {"A", 1}, {"U", 1}, {"Y", 1}]
  @minheap {{0, 0}, {"A", 1}, {"U", 1}, {"I", 2}, {"Y", 1}, {"H", 3}, {"P", 2}, {"R", 2}}
  test "calculate the frequency of each character in the string" do
    assert HuffmanCoding.frequency("") == %{}
    assert HuffmanCoding.frequency(@string) == @frequency_list
  end

  test "heapify the frequency matrix" do
    assert HuffmanCoding.heapify([]) == {{0,0}}
    assert HuffmanCoding.heapify(@frequency_list) == {{0, 0},{"A", 1}, {"U", 1}, {"I", 2}, {"Y", 1}, {"H", 3}, {"P", 2}, {"R", 2}}
  end

  test "get the minimum element from a minheap" do
    assert HuffmanCoding.remove_from_heap({}) == {{}, nil}

    assert HuffmanCoding.remove_from_heap(@minheap) == {{{0, 0}, {"U", 1}, {"Y", 1}, {"I", 2}, {"R", 2}, {"H", 3}, {"P", 2}}, {"A", 1}}
  end

  test "create the first element for huffman tree" do
    assert HuffmanCoding.create_leaf_node(@minheap) == {%{'left' => {"A", 1}, 'right' => {"U", 1}, 'val' => 2},
                                                      {{"Y", 1}, {"R", 2}, {"I", 2}, {"P", 2}, {"H", 3}}}
  end

  test "create the huffman tree" do
    assert HuffmanCoding.create_huffman_tree(@minheap) == %{'left' => {"H", 3}, 'right' => %{'left' => {"A", 1}, 'right' => {"U", 1}, 'val' => 2},
                                  'val' => 5}
  end
end
