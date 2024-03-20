# Interoperability Test

Questa repository contiene alcuni test per verificare le performance di Elixir.
Viene usato anche del codice esterno in alcuni test per verificare l'interoperabilità.

Il codice NIF si trova in `./external_code/nif`, le due shared library sono già compilate per linux
si trovano nella cartella `./priv`
.

## Requisiti per eseguire la demo

- Erlang installato
- Elixir installato

## Esecuzione demo

La prima volta scaricare le dipendenze:

- `mix deps.get`

---

### Demo speedtest somma n elementi

- `iex -S mix`
- `SpeedElixir.speedtest(1000000)` oppure `SpeedElixir.speedtest2(1000000)`

<!-- ![Esempio Demo](./readme_docs/Pasted%20image%2020240312184053.png) -->

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

Si è sperimentato un server http con la libreria `plug_cowboy`
configurare MyHttpApplication come funzione di avvio per testare
ed eseguire mix run --no-halt.

## Eseguire Hello world Nif del modulo ElixirNif

```bash
iex -S mix
```

ed

```ruby
ElixirNif.hello
```
