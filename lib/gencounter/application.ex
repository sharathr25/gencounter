defmodule Gencounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Gencounter.Worker.start_link(arg)
      # {Gencounter.Worker, arg}
      {GenCounter.Producer, 0},
      GenCounter.ProducerConsumer,
      # if we need only one consumer worker the we can just use below
      # GenCounter.Consumer,
      # if we need multiple workers we can use below
      Supervisor.child_spec(GenCounter.Consumer, id: :consumer_1),
      Supervisor.child_spec(GenCounter.Consumer, id: :consumer_2),
      Supervisor.child_spec(GenCounter.Consumer, id: :consumer_3)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gencounter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
