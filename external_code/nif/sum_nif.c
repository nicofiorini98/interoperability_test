#include "./includeErl/erl_nif.h" // only for debug, not compile with this
// Remove to compile
// #include "erl_nif.h" 
#include "string.h"



// how to compile the shared library to load in erlang VM
// gcc -fPIC -shared -o elixir_nif.so elixir_nif.c -I $ERL_ROOT/usr/include/

// to find $ERL_ROOT PATH execute this command: elixir -e "IO.puts :code.root_dir()"



// Funzione iterativa per calcolare la somma dei numeri da 1 a N
// dichiarare la funzione static per limitare l'accesso a funzioni che non devono essere esposte
// all'esterno del modulo
static ERL_NIF_TERM sum_iterative_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
    int n;
    if (!enif_get_int(env, argv[0], &n)) {
        return enif_make_badarg(env);
    }

    // Calcola la somma iterativa
    double sum = 0;
    for (int i = 1; i <= n; i++) {
        sum += i;
    }

    // Restituisci il risultato come termine NIF
	return enif_make_double(env, sum);
    // return enif_make_int(env, sum);
}

// Definizione dei metodi NIF
static ErlNifFunc nif_funcs[] = {
    {"sum_iterative_nif", 1, sum_iterative_nif}
};

// Funzione di caricamento del modulo NIF
ERL_NIF_INIT(Elixir.SpeedElixir, nif_funcs, NULL, NULL, NULL, NULL)
