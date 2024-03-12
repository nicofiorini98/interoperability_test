defmodule CallErlport do
  def start_python do
    {:ok, pid} = :python.start()
    # _version = :python.call(pid, :sys, :'version.__str__', [])
    {:ok, result} = :python.call("example.py", [])
    IO.puts("Output from Python script: #{result}")
    pid
  end
end
