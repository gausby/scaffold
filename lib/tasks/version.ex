defmodule Mix.Tasks.Scaffold.Version do
  use Mix.Task

  @shortdoc "Return the scaffold version number"
  @moduledoc """
  Return the version number of the installed scaffold command.

      mix scaffold.version

  """

  @version Mix.Project.config[:version]  

  @spec run(Any) :: :ok
  def run(_), do: Mix.shell.info @version

end
