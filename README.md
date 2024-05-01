# Interoperability and http Test in Elixir

Questa repository contiene alcuni test per verificare le performance di Elixir,
vengono testati dei metodi di interoperabilità in Elixir e un server http con la libreria
`Plug`.

Il codice NIF si trova in `./external_code/nif`, le due shared library sono già compilate per linux con il compilatore gcc, le librerie compilate
si trovano nella cartella `./priv`
.

## Requisiti per eseguire la demo

- Erlang installato
- Elixir installato

## Esecuzione demo

La prima volta scaricare le dipendenze:

- `mix deps.get`

---

### Tcp server

Si è sperimentato un Tcp echo server che risponde con il messaggio
inviato ma maiuscolo.

Nel file di configurazione `mix.exs` ci sono varie funzioni
decommentare MyTcpApplication per eseguire il server TCP.

```ruby
def application do
    [
      extra_applications: [:logger],
      mod: {InteroperabilityTest.MyTcpApplication,[]} # funnzione da eseguire per inizializzare ilTCP server
      # mod: {InteroperabilityTest.MyHttpApplication,[]}
    ]
  end
```

Then execute:

```bash
mix run --no-halt
```

---

### Http Server

Si è sperimentato un server http con la libreria `plug_cowboy`,
decommentare la riga nel file `mix.exs`:

```elixir
mod: {InteroperabilityTest.MyHttpApplication,[]}
```

ed eseguire:

```bash
iex -S mix
```

Con l'ambiente interattivo avviato, dovreste vedere la stringa:

```text
[info] Starting application on port 5000..
```

---

### Benchmark Interoperabilita

Vengono fatti dei benchamark di interoperabilità confrontando 4 strategie di
implementazione:

1. Funzione Elixir con ricorsione semplice
2. Funzione Elixir con ricorsione ottimizzata
3. Funzione cpp con IPC tramite Port
4. Funzione cpp tramite funzione nativa, compilata come shared object ("./priv/list_sum_iterative_nif")

Il codice NIF non compilato si trova "./external_code/nif/list_sum.cpp"
Il codice C++ per Port si trova "./external_code/c_src/list_sum_port.cpp"

#### Come compilare un NIF

[Documentazione NIF](https://www.erlang.org/doc/man/erl_nif)
Compilare con gcc il codice nif come libreria condivisa (.so)
facendo attenzione ad includere l'header `erl_nif.h` presente
nell'installazione di Erlang.

```bash
# Posizionarsi nella cartella root del progetto nel terminale
gcc -o ./priv/sum_iterative_nif.so -shared -fpic -I $ERL_ROOT/usr/include ./external_code/nif/sum_nif.c
```

Sostituire il path $ERL_ROOT con il path della vostra installazione erlang.
Per trovare il path si può eseguire: `elixir -e "IO.puts :code.root_dir()"`
