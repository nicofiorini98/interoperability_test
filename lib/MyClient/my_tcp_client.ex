defmodule MyClient do
  def connect(server_ip, server_port) do
    {:ok, socket} = :gen_tcp.connect(server_ip, server_port, [:binary, active: false])
    loop_sender(socket)
  end

  defp loop_sender(socket) do
    :gen_tcp.send(socket, "Dati da inviare al server")
    loop_sender(socket)
  end
end
