defmodule Benchmark.SpeedElixirApplication do
  use Application


  @impl true
  def start(_type,_args) do
    SpeedElixir.speed_test2()
    IO.puts("Hello my friend")
    {:ok,self()}
  end

end
