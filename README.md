# Interoperability Test

Questa repository contiene alcuni test per verificare le performance di Elixir.
Viene usato anche del codice esterno in alcuni test per verificare l'interoperabilità.

Il codice NIF si trova in `./external_code/nif`, le due .so compilate per linux sono
in `./priv`.

## Requisiti per eseguire la demo

- Erlang installato
- Elixir installato

## Esecuzione demo

The first time you run the program, download the depencies executing: 

- `mix deps.get`

una volta scaricate le dipendenze eseguire:

- `iex -S mix`
- `SpeedElixir.speedtest(1000000)` oppure `SpeedElixir.speedtest(1000000)`

## Come compilare un NIF

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

![Esempio Demo](./readme_docs/Pasted%20image%2020240312184053.png)


---

### Tcp Echo server
Starting TCP echo server, is a simple test for tcp connections.
In mix.exs configuration file there are various function to initialize the
application. Uncomment the one you want to run.
```ruby
def application do
    [
      extra_applications: [:logger],
      # mod: {InteroperabilityTest.MyTcpApplication,[]}
      # mod: {InteroperabilityTest.MyHttpApplication,[]}
    ]
  end
```

Then execute:

```bash
mix run --no-halt
```

--- 

## Eseguire Hello world Nif del modulo ElixirNif

```bash 
iex -S mix
```
ed

```ruby
ElixirNif.hello
```
