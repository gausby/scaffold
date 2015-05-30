defmodule ScaffoldHelpersTest do
  use ExUnit.Case
  
  test "should sort the directories correctly" do
    data = [
      "BB/F.txt",
      "A.txt",
      "AA/AA/BB/D.txt",
      "AA/AA/C.txt",
      "AA/AA/E.txt",
      "AA/B.txt"
    ]

    result = Enum.sort(data, &Scaffold.Helpers.sort_by_folder_and_filename/2)
    assert result == ["A.txt", "AA/B.txt", "AA/AA/C.txt", "AA/AA/E.txt", "AA/AA/BB/D.txt", "BB/F.txt"]
  end
end
