defmodule Benchmark.SpeedElixirApplication do
  use Application


  @impl true
  def start(_type,_args) do

    # uncomment to start observer with the application
    # Observer.start_observer()

    # SpeedElixir.speed_test2()
    # SpeedSum.speed_test([1_000_000,2_000_000,3_000_000,4_000_000]);

    IO.puts("Hello my friend, facciamo qualche Benchmark di interoperabilita'")
    {:ok,self()}
  end
end
