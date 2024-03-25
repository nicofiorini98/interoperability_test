defmodule Examples.Counter3 do

  def start_link(initial_value) do
    spawn_link(__MODULE__,:loop,[initial_value])
  end

  def loop(counter) do
    receive do
      {:read, {caller,ref}} ->
        send(caller,{ref,counter})
        loop(counter)
      {:bump} ->
        loop(counter + 1)
    end

  end

  def read(counter_pid, timeout \\ 5000) do

    ref = Process.monitor(counter_pid)
    send counter_pid, {:read,{self(),ref}}

    receive do
      {^ref, counter} ->
        Process.demonitor(ref,[:flush])
        {:ok,counter}
      {:DOWN,^ref,_,_,reason} -> exit(reason)

    after
      timeout -> exit(:timeout)
    end
  end

  def bump(counter_pid) do
    send counter_pid, :bump
  end

end
