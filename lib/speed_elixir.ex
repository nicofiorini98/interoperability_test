defmodule SpeedElixir do

  # **************************** NIF **********************************#
  @on_load :load_nif

  ## this function fool for a so or a dll
  ## return Ok if the nif is loaded
  def load_nif do
    :ok = :erlang.load_nif(String.to_charlist("priv/sum_iterative_nif"), 0)
  end

  def sum_iterative_nif(_n) do
    :erlang.nif_error("Errore nel caricamento nif")
  end

  # ************************ SUM RECURSIVE *****************************#

  # Funzione ricorsiva per calcolare la somma dei numeri da 1 a N
  # Questa funzione ricorsiva non è ottimizzata con la tail_recursion
  # Da ottimizzare
  def sum_recursive(0), do: 0
  def sum_recursive(n), do: n + sum_recursive(n - 1)

  # ************************SUM RECURSIVE OTTIMIZZATA *******************#

  # Funzione di somma ricorsiva ottimizzata
  def sum_recursive2(0, acc), do: acc
  def sum_recursive2(n, acc) when n > 0, do: sum_recursive2(n - 1, acc + n)

  # ************************SUM ITERATIVA *******************************#

  # Funzione utilizzando un ciclo per calcolare la somma dei numeri da 1 a N
  def sum_iterative(n) do
    Enum.reduce(1..n, 0, &(&1 + &2))
  end

  # ********************* SUM PORT **************************************#

  def sum_port(n) do
    # apertura della porta
    port = Port.open({:spawn, "./priv/speedtest_port"}, [:binary, :use_stdio])

    Port.command(port, "#{n}\n")

    receive do
      {^port, {:data, result}} ->
        # IO.puts("Somma dei primi #{n} numeri: #{String.trim(result)}")
        String.trim(result)

      {^port, {:exit_status, status}} ->
        IO.puts("Processo port terminato con codice di uscita #{status}")
    after
      1000 ->
        IO.puts("Timeout")
    end

    # receive do
    #   {self(),result}
    # end

    Port.close(port)
  end

  # ************************ SPEED TEST **********************************#
  # Funzione per eseguire il test di velocità
  def speed_test(n \\ 1_000_000) when is_number(n) and n > 0 do
    # Misura il tempo di esecuzione della funzione sum_recursive
    {time_recursive, result_recursive} = :timer.tc(&sum_recursive/1, [n])

    IO.puts(
      "Tempo sum_recursive -------------:#{time_recursive} microsec, risultato: #{result_recursive}"
    )

    # Misura il tempo di esecuzione della funzione sum_recursive2 ottimizzata con la tail_recursion
    {time_recursive2, result_recursive2} = :timer.tc(&sum_recursive2/2, [n, 0])
    IO.puts(
      "Tempo sum_recursive_ottimizzata: #{time_recursive2} microsec, risultato: #{result_recursive2}"
    )

    # Misura il tempo di esecuzione della funzione sum_iterative
    {time_iterative, result_iterative} = :timer.tc(&sum_iterative/1, [n])
    IO.puts(
      "Tempo sum_iterative-------------:#{time_iterative} microsec, risultato: #{result_iterative}"
    )

    {time_iterative_nif, result_iterative_nif} = :timer.tc(&sum_port/1, [n])
    IO.puts(
      "Tempo sum_port-------------------:#{time_iterative_nif} microsec, risultato: #{result_iterative_nif}"
    )

    {time_iterative_nif, result_iterative_nif} = :timer.tc(&sum_iterative_nif/1, [n])
    IO.puts(
      "Tempo sum_iterative con nif------:#{time_iterative_nif} microsec, risultato: #{result_iterative_nif}"
    )
  end

  # ************************ SPEED TEST 2 **********************************#
  # With Benchee library
  def speed_test2(n \\ 1_000_000) do

    Benchee.run(%{
      "sum_recursive" => fn -> sum_recursive(n) end,
      "sum_recursive2" => fn -> sum_recursive2(n,0) end,
      "sum_iterative" => fn -> sum_iterative(n) end,
      "sum_port" => fn -> sum_port(n) end,
      "sum_iterative_nif" => fn -> sum_iterative_nif(n) end
    })
  end
end
