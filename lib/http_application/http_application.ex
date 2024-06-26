defmodule InteroperabilityTest.MyHttpApplication do
  use Application
  require Logger

  def start(_type, _args) do

    # uncomment to start observer with the application
    # Observer.start_observer()

    children = [
      {Plug.Cowboy, scheme: :http, plug: MyRouter, options: [port: cowboy_port()]}
    ]

    # opzioni per il supervisor del modulo Myhttp
    opts = [strategy: :one_for_one, name: MyHttpServer.Supervisor]

    Logger.info("Starting application on port #{cowboy_port()}...")

    Supervisor.start_link(children, opts)


  end

  defp cowboy_port, do: Application.get_env(:example, :cowboy_port, 5000)



end
