defmodule HTTPSimulator do
  use HTTPoison.Base

  # Imposta il timeout globale per le richieste
  # @timeout 5000

  # Funzione per inviare una richiesta HTTP GET
  def send_get_request(url \\ "http::/localhost:8080") do
    {:ok, _response} = get(url)
  end

  # Funzione per simulare n richieste HTTP GET concorrenti
  def simulate_http_requests(url, n \\10) do
    # Avvia n processi concorrenti, ciascuno dei quali invia una richiesta GET
    Enum.map(1..n, fn _ ->
      spawn(fn -> send_get_request(url) end)
    end)
  end
end
