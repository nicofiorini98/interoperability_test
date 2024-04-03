defmodule SpeedSum do
  # **************************** NIF **********************************#
  @on_load :load_nif

  ## this function fool for a so or a dll
  ## return Ok if the nif is loaded
  def load_nif do
    :ok = :erlang.load_nif(String.to_charlist("priv/list_sum_iterative_nif"), 0)
  end

  def list_sum_iterative_nif(_n) do
    :erlang.nif_error("Errore nel caricamento nif")
  end

  # ***********************
  # ************************ SUM RECURSIVE *****************************#

  # Funzione ricorsiva per calcolare la somma dei numeri da 1 a N
  # Questa funzione ricorsiva non è ottimizzata con la tail_recursion
  # Da ottimizzare

  def list_sum_recursive(list) when is_list(list) do
    result_list = Enum.map(list, fn x -> sum_recursive(x) end)
    result_list
  end

  #caso base
  defp sum_recursive(0), do: 0

  defp sum_recursive(n), do: n + sum_recursive(n - 1)

  # ************************SUM RECURSIVE OTTIMIZZATA *******************#

  # Funzione di somma ricorsiva ottimizzata
  def list_sum_recursive_tail(list) when is_list(list) do
    result_list = Enum.map(list, fn x -> sum_recursive_tail(x, 0) end)
    result_list
  end

  #caso base
  defp sum_recursive_tail(0, acc), do: acc

  defp sum_recursive_tail(n, acc) when n > 0, do: sum_recursive_tail(n - 1, acc + n)




# ****************** LIST SUM PORT ***********************

  def list_sum_port(list) when is_list(list) do

    # Apertura del Port
    port = Port.open({:spawn_executable, "./priv/testcpp"}, [:binary,:use_stdio])

    # encoding del messaggio da inviare al port
    message = Enum.join(list,", ")

    # invio del messaggio al port
    Port.command(port, "#{message}\n")

    receive do
      {^port, {:data, result}} ->
        String.trim(result)

      {^port, {:exit_status, status}} ->
        IO.puts("Processo port terminato con codice di uscita #{status}")
    after
      1000 ->
        IO.puts("Timeout")
    end
    Port.close(port)

  end

  # ************************ SPEED TEST 2 **********************************#
  # With Benchee library
  def speed_test() do
    list_input = [1_000_000, 2_000_000,5_000_000]
    Benchee.run(
      %{
        "sum_recursive" => fn -> list_sum_recursive(list_input) end,
        "sum_recursive_tail" => fn -> list_sum_recursive_tail(list_input) end,
        "sum_iterative_nif" => fn -> list_sum_iterative_nif(list_input) end,
        "list_sum_port" => fn -> list_sum_port(list_input) end
      },
      warmup: 4,
      memory_time: 4,
      formatters: [
        Benchee.Formatters.HTML,
        Benchee.Formatters.Console
      ])
  end
end
