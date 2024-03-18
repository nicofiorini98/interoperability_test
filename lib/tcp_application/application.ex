defmodule InteroperabilityTest.MyApplication do
  @moduledoc false
  use Application


  @impl true
  def start(_type, _args) do

    port = String.to_integer(System.get_env("PORT") || "4040")

    children = [
      {Task.Supervisor, name: MyTCPServer.TaskSupervisor},
      {Task, fn -> MyTCPServer.accept(port) end}
    ]

    opts = [strategy: :one_for_one, name: MyTCPServer.Supervisor]
    Supervisor.start_link(children, opts)

  end

end
