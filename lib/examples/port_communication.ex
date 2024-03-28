defmodule PortCommunication do
  def start_port() do
    # Apri il port con opzioni per la comunicazione tramite stringhe
    port = Port.open({:spawn, "elixir .external_code/all_caps.exs"}, [:binary])

    Port.command(port, "hello\n")
    # Receive message
    receive do
      {^port, {:data, data}} -> IO.inspect("Got: #{data}")
    end

    send(port, {self(), :close})

    receive do
      {^port, :closed} -> IO.puts("Closed")
    end
  end

  def start_port_packet() do
    port = Port.open({:spawn, "elixir ./external_code/all_caps_packet.exs"}, [:binary, packet: 4])
    Port.command(port, "command without newline")

    receive do
      {^port, {:data, data}} ->
        IO.puts("Got: #{data}")
    end

    Port.close(port)
    IO.puts("Closed")
  end

end
