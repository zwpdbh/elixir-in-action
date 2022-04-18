defmodule OurNewApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: OurNewApp.Worker.start_link(arg)
      # {OurNewApp.Worker, arg}
      {OurNewApp.CounterSup, [10000, 20000]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OurNewApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
