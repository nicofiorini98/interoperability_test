defmodule Examples.Counter do

  def start_link(initial_value) do
    spawn_link(__MODULE__,:loop,[initial_value])
  end

  def loop(counter) do
    receive do
      {:read, caller} ->
        send(caller,{:counter,counter})
        loop(counter)
      {:bump} ->
        loop(counter + 1)
    end

  end

  def read(counter_pid) do
    send counter_pid, {:read,self()}
    receive do
      {:counter,counter} -> {:ok,counter}
    end
  end

  def bump(counter_pid) do
    send counter_pid, :bump
  end

end
