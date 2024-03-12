
defmodule SpeedElixir do

  @on_load :load_nif

 ## this function fool for a so or a dll
 ## return Ok if the nif is loaded
 def load_nif do
  :ok = :erlang.load_nif(String.to_charlist("priv/sum_iterative_nif"), 0)
 end

 def sum_iterative_nif(n) do
  :erlang.nif_error("Errore nel caricamento nif")
 end


  # Funzione ricorsiva per calcolare la somma dei numeri da 1 a N
  # Questa funzione ricorsiva non è ottimizzata con la tail_recursion
  # Da ottimizzare
  def sum_recursive(0), do: 0
  def sum_recursive(n), do: n + sum_recursive(n - 1)

# Funzione di somma ricorsiva ottimizzata
  def sum_recursive2(0, acc), do: acc
  def sum_recursive2(n, acc) when n > 0, do: sum_recursive2(n - 1, acc + n)

  # Funzione utilizzando un ciclo per calcolare la somma dei numeri da 1 a N
  def sum_iterative(n) do
    Enum.reduce(1..n, 0, &(&1 + &2))
  end

  # Funzione per eseguire il test di velocità
  def speed_test(n) do
    # Misura il tempo di esecuzione della funzione sum_recursive
    {time_recursive, result_recursive} = :timer.tc(&sum_recursive/1, [n])
    IO.puts "Tempo sum_recursive:             #{time_recursive} microsec, risultato: #{result_recursive}"

    # Misura il tempo di esecuzione della funzione sum_recursive2 ottimizzata con la tail_recursion
    {time_recursive2, result_recursive2} = :timer.tc(&sum_recursive2/2, [n,0])
    IO.puts "Tempo sum_recursive_ottimizzata: #{time_recursive2} microsec, risultato: #{result_recursive2}"

    # Misura il tempo di esecuzione della funzione sum_iterative
    {time_iterative, result_iterative} = :timer.tc(&sum_iterative/1, [n])
    IO.puts "Tempo sum_iterative:             #{time_iterative} microsec, risultato: #{result_iterative}"

    {time_iterative_nif, result_iterative_nif} = :timer.tc(&sum_iterative_nif/1, [n])
    IO.puts "Tempo sum_iterative con nif:     #{time_iterative_nif} microsec, risultato: #{result_iterative_nif}"
  end
end
