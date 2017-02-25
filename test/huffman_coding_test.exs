defmodule HuffmanCodingTest do
  use ExUnit.Case
  doctest HuffmanCoding

  @string "hip hip hurray"
  @frequency_list [{"H", 3}, {"I", 2}, {"P", 2}, {"R", 2}, {"A", 1}, {"U", 1}, {"Y", 1}]
  @minheap {{0, 0}, {"A", 1}, {"U", 1}, {"I", 2}, {"Y", 1}, {"H", 3}, {"P", 2}, {"R", 2}}
  @hufftree %{'left' => {"H", 3}, 'right' => %{'left' => {"Y", 1}, 'right' => %{'left' => {"P", 2}, 'right' => %{'left' => {"I", 2}, 'right' => %{'left' => {"R", 2}, 'right' => %{'left' => {"A", 1}, 'right' => {"U", 1}, 'val' => 2}, 'val' => 4}, 'val' => 6}, 'val' => 8}, 'val' => 9}, 'val' => 12}
  @huffcode %{"A" => "111110", "H" => "0", "I" => "1110", "P" => "110", "R" => "11110", "U" => "111111", "Y" => "10"}

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
    assert HuffmanCoding.create_huffman_tree(@minheap) ==  @hufftree
  end

  test "huffman encoding" do
    assert HuffmanCoding.encode(@hufftree) == {@huffcode, "11111"}
  end

  test "get the huffman encoding of a string" do
    assert HuffmanCoding.huffman_coding("hello, world") == %{"D" => "111110", "E" => "111111", "H" => "1110", "L" => "0",
                                                                        "O" => "110", "R" => "11110", "W" => "10"}
  end
end
