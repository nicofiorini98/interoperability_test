
port = Port.open({:spawn_executable, "./priv/testcpp"}, [:binary])

send(port, {self(), {:command, "1000\n"}})

receive do
  {^port, {:data, result}} ->
    IO.puts("Lista delle somme: #{result}")
    # String.trim()

  {^port, {:exit_status, status}} ->
    IO.puts("Processo port terminato con codice di uscita #{status}")
after
  10000 ->
    IO.puts("Timeout")
end

Port.close(port)
