defmodule Examples.Memory do
  def mypid do
    receive do
      :stop -> :exit
      _ -> mypid()
    end
  end

  def benchmark_spawn do
    pid = spawn(fn -> mypid() end)
    {_,byte_used} = :erlang.process_info(pid,:memory)
    IO.puts("La memoria usata dal processo è: #{byte_used}")
    send pid, :stop
  end
  
  
  def benchmark_spawn_link do
    pid = spawn_link(fn -> mypid() end)
    {_,byte_used} = :erlang.process_info(pid,:memory)
    IO.puts("La memoria usata dal processo è: #{byte_used}")
    send pid, :stop
  end
end
