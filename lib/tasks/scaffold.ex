defmodule Mix.Tasks.Scaffold do
  use Mix.Task

  import Mix.Generator
  
  @shortdoc "Generate a project based on the content of a Git-repo"
  @moduledoc """
  Generate a project based on the content of a Git-repo in the given path.

      mix scaffold PATH [--template branch_name]

  If the `--template` name is set it will use that branch name as the template.
  """
  
  @spec run(OptionParser.argv) :: :ok
  def run(argv) do
    {opts, argv, _} = OptionParser.parse(argv, switches: [])

    case argv do
      [] ->
        Mix.raise "Expected path to be given, please use `mix scaffold PATH`"
      [path | _rest] ->
        config = get_git_config!
        scaffold_dir = get_in(config, ["scaffold", "dir"])

        if scaffold_dir == nil, do: Mix.raise """
        No template dir found. Please add one with:

            git config --global scaffold.dir PATH_TO_TEMPLATE_DIR

        Read the documentation for more info.
        """

        check_for_valid_git_repository!(scaffold_dir)

        repo = Gitex.Git.open(scaffold_dir)
        branch = opts[:template] || "master"

        # Gitex will throw an FunctionClauseError if the repo is empty
        content = try do
          Gitex.get(branch, repo, "/")
        rescue
          FunctionClauseError -> nil
        end
        if content == nil, do: Mix.raise "Template seems to be empty"
        
        File.mkdir_p!(path)
        File.cd!(path, fn ->
          walk_tree(content, {"/", repo, branch}, %{})
          |> Dict.keys
          |> Enum.sort(&Scaffold.Helpers.sort_by_folder_and_filename/2)
          |> Enum.each(fn file ->
            file_destination = String.lstrip(file, ?/)
            dir_name = Path.dirname(file_destination)
            unless File.dir?(dir_name), do: create_directory(dir_name)

            create_file(file_destination, Gitex.get(branch, repo, file))
          end)
        end)

        Mix.shell.info "The project was generated successfully"
    end
  end

  # read the user settings from the ~/.gitconfig, raise if it does not exist
  defp get_git_config! do
    file_name = ".gitconfig"
    gitconfig = System.user_home! |> Path.join(file_name)
    if File.exists?(gitconfig) do
      case ConfigParser.parse_file(gitconfig) do
        {:ok, config} -> config
        _ -> Mix.raise "Could not read #{file_name} in #{System.user_home!}"
      end
    else
      Mix.raise "A #{file_name} file could not be found in #{System.user_home!}"
    end
  end

  defp check_for_valid_git_repository!(dir) do
    unless (File.dir?(dir) && File.dir?(Path.join(dir, ".git"))) do
      Mix.raise "Please create a .scaffold-folder with a git repository in your home dir"
    end
  end
  
  # Walk the .git folder and fetch the names and file paths of the given branch.
  defp walk_tree(node, connection, acc) when is_list(node) do
    Enum.reduce(node, acc, fn (node, acc) -> walk_tree(node, connection, acc) end)
  end
  defp walk_tree(%{type: :dir, name: file_name}, {prefix, repo, branch}, acc) do
    dir_name = Path.join(prefix, file_name)
    content = Gitex.get(branch, repo, dir_name)
    walk_tree(content, {dir_name, repo, branch}, acc)
  end
  defp walk_tree(%{type: :file, name: file_name} = node, {prefix, _, _}, acc) do
    file_name_and_path = Path.join(prefix, file_name)
    Map.put(acc, file_name_and_path, node)
  end

end
