defmodule PythonApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: PythonElixir.Worker.start_link(arg)
      # {PythonElixir.Worker, arg}
      :poolboy.child_spec(:worker, python_poolboy_config())
    ]

    opts = [strategy: :one_for_one, name: PythonElixir.Supervisor] # Chiama il Supervisor PythonElixir.Supervisor
    Supervisor.start_link(children, opts)
  end

  defp python_poolboy_config do
    [
      {:name, {:local, :python_worker}},     # scope locale e nome del pool :python_worker
      {:worker_module, PythonWorker},        # Il processo worker sta nel modulo CallPython
      {:size, 5},                            # utilizzo di al massimo 5 processi
      {:max_overflow, 0}                     # non overflow dei processi
    ]
  end
end
