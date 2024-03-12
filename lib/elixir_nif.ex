defmodule ElixirNif do

  # this annotation tells the VM to execute the load_nif/0 function
  # timing is important.
 @on_load :load_nif

 ## this function fool for a so or a dll
 ## return Ok if the nif is loaded
 def load_nif do
  # nif = Application.app_dir(:elixir_nif, "priv/elixir_nif")
  # :ok = :erlang.load_nif(String.to_charlist(nif), 0)
  :ok = :erlang.load_nif(String.to_charlist("priv/elixir_nif"), 0)
  # :ok = :erlang.load_nif(String.to_charlist("priv/elixir_nif"), 0)
 end

 def sum_n_natural(n) when is_integer(n) and n >=0 do
   :erlang.nif_error("NIF library not found")
 end

 ## di default viene chiamata la funzione del NIF
 ## la funzione del nif è da definire a quanto pare obbligotoriamente anche in Elixir
 def hello do
   :erlang.nif_error("NIF library not found")
 end

end
