defmodule Scaffold.Mixfile do
  use Mix.Project

  @version File.read!("VERSION") |> String.strip
  defp description do
    """
    A mix task for creating new projects based on templates fetched from a Git-repo.
    """
  end
  
  def project do
    [app: :scaffold,
     version: @version,
     description: description,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:gitex, "~> 0.1.0"}]
  end

  defp package do
    %{
      licenses: ["Apache v2.0"],
      contributors: [
        "Martin Gausby"
      ],
      links: %{
        "GitHub" => "https://github.com/gausby/scaffold",
        "Bugs" => "https://github.com/gausby/scaffold/issues"
      },
      files: ~w(lib config mix.exs LICENSE VERSION README*)
    }
  end
end
