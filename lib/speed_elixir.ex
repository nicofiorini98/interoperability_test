
defmodule SpeedElixir do
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
    {time_recursive, result_recursive} = :timer.tc(&sum_recursive/1, [n],:millisecond)
    IO.puts "Tempo sum_recursive:             #{time_recursive} ms, risultato: #{result_recursive}"

    # Misura il tempo di esecuzione della funzione sum_recursive2 ottimizzata con la tail_recursion
    {time_recursive2, result_recursive2} = :timer.tc(&sum_recursive2/2, [n,0],:millisecond)
    IO.puts "Tempo sum_recursive_ottimizzata: #{time_recursive2} ms, risultato: #{result_recursive2}"

    # Misura il tempo di esecuzione della funzione sum_iterative
    {time_iterative, result_iterative} = :timer.tc(&sum_iterative/1, [n],:millisecond)
    IO.puts "Tempo sum_iterative:             #{time_iterative} ms, risultato: #{result_iterative}"
  end
end
