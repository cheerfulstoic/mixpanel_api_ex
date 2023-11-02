defmodule Mixpanel.Mixfile do
  use Mix.Project

  @version "1.1.1"

  def project do
    [
      app: :mixpanel_api_ex,
      version: @version,
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: [
        plt_core_path: "priv/plts",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        plt_add_deps: :apps_direct,
        plt_add_apps: [:logger, :inets],
        flags: [
          "-Werror_handling",
          "-Wextra_return",
          "-Wmissing_return",
          "-Wunknown",
          "-Wunmatched_returns",
          "-Wunderspecs"
        ]
      ],
      test_coverage: [
        summary: [
          threshold: 80
        ]
      ],

      # Hex
      description: description(),
      package: package(),

      # Docs
      name: "Mixpanel API",
      docs: [
        extras: ["README.md", "CHANGELOG.md"],
        source_ref: "v#{@version}",
        main: "Mixpanel",
        source_url: "https://github.com/asakura/mixpanel_api_ex"
      ]
    ]
  end

  def description do
    "Elixir client for the Mixpanel API."
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]

  def package do
    [
      maintainers: ["Mikalai Seva"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/asakura/mixpanel_api_ex"},
      files: ~w(mix.exs README.md CHANGELOG.md lib)
    ]
  end

  def application() do
    [mod: {Mixpanel, []}, extra_applications: [:logger]]
  end

  defp deps do
    [
      {:bandit, "~> 1.0", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:gradient, github: "esl/gradient", ref: "33e13fb", only: [:dev], runtime: false},
      {:gradient_macros, github: "esl/gradient_macros", ref: "3bce214", runtime: false},
      {:hackney, "~> 1.20", only: [:test, :dev]},
      {:jason, "~> 1.4"},
      {:machete, "~> 0.2", only: :test},
      {:mox, "~> 1.1", only: :test},
      {:telemetry, "~> 0.4 or ~> 1.0"},
    ]
  end

  defp aliases() do
    [
      test: "test --no-start"
    ]
  end
end
