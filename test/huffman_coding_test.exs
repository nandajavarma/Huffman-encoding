defmodule HuffmanCodingTest do
  use ExUnit.Case
  doctest HuffmanCoding

  @string "hip hip hurray"
  @frequency_list [{"H", 3}, {"I", 2}, {"P", 2}, {"R", 2}, {"A", 1}, {"U", 1}, {"Y", 1}]
  test "calculate the frequency of each character in the string" do
    assert HuffmanCoding.frequency("") == %{}
    assert HuffmanCoding.frequency(@string) == @frequency_list
  end

  test "heapify the frequency matrix" do
    assert HuffmanCoding.heapify([]) == {}
    assert HuffmanCoding.heapify(@frequency_list) == {{"A", 1}, {"U", 1}, {"I", 2}, {"Y", 1}, {"H", 3}, {"P", 2}, {"R", 2}}
  end
end
