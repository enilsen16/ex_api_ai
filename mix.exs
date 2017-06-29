defmodule ApiAi.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_api_ai,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Elixir wrapper for @api_ai",
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.11.0"},
      {:poison, "~> 2.0"},
      {:exvcr, "~> 0.8", only: :test}
    ]
  end

  defp package do
    [
      maintainers: ["Erik Nilsen"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/enilsen16/ex_api_ai",
      }
    ]
  end
end
