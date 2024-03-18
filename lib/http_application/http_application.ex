defmodule InteroperabilityTest.MyHttpApplication do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: 8080]}
    ]

    # opzioni per il supervisor del modulo Myhttp
    opts = [strategy: :one_for_one, name: MyHttpServer.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end

end
