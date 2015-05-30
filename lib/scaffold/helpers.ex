defmodule Scaffold.Helpers do
  @doc """
  We want to sort by file name if we compare two files in the same folder.
  In other cases we want to sort the directories.

  This function is passed to `Enum.sort/2`
  """
  def sort_by_folder_and_filename(a, b) do
    a_dirname = Path.dirname(a)
    b_dirname = Path.dirname(b)

    if (a_dirname == b_dirname) do
      Path.basename(a) < Path.basename(b)
    else
      a_dirname < b_dirname
    end
  end
end
