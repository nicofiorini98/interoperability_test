# Interoperability Test

Questa repository contiene alcuni test per capire come Elixir si interfaccia
con altri linguaggi.

Il codice NIF si trova in `./external_code/nif`, le due .so compilate per linux sono
in `./priv`.

## Requisiti per eseguire la demo

- Erlang installato
- Elixir installato

## Esecuzione demo

The first time you run the program, download the depencies executing: `mix deps.get`

- `iex -S mix`
- `SpeedElixir.speedtest(1000000)`

## Come compilare un NIF

[Documentazione NIF](https://www.erlang.org/doc/man/erl_nif)
Compilare con gcc il codice nif come libreria condivisa (.so)

```bash
# Posizionarsi nella cartella root del progetto nel terminale
gcc -o ./priv/sum_iterative_nif.so -shared -fpic -I $ERL_ROOT/usr/include ./external_code/nif/sum_nif.c
```

Sostituire il path $ERL_ROOT con il path della vostra installazione erlang.
Per trovare il path si può eseguire: `elixir -e "IO.puts :code.root_dir()"`

---

![Esempio Demo](./readme_docs/Pasted%20image%2020240312184053.png)


---
Starting TCP echo server, is a simple test for tcp connections

```bash
PORT=4321 mix run --no-halt
```
