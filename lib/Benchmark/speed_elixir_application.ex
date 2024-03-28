defmodule Benchmark.SpeedElixirApplication do
  use Application


  @impl true
  def start(_type,_args) do

    # uncomment to start observer with the application
    Observer.start_observer()

    SpeedElixir.speed_test2()

    IO.puts("Hello my friend")
    {:ok,self()}
  end

end
