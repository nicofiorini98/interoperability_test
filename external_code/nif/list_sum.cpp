#include "./includeErl/erl_nif.h" // only for debug, not compile with this
// Remove to compile
#include "erl_nif.h" 
#include "string.h"
#include <iostream>
#include <vector>


// how to compile the shared library to load in erlang VM
// gcc -fPIC -shared -o elixir_nif.so elixir_nif.c -I $ERL_ROOT/usr/include/

// to find $ERL_ROOT PATH execute this command: elixir -e "IO.puts :code.root_dir()"


// serve per riempire un vector da una lista
inline bool fillVector(ErlNifEnv* env, ERL_NIF_TERM listTerm, std::vector<long int>& result) 
{
    unsigned int length = 0;
    
    if (!enif_get_list_length(env, listTerm, &length)) {
        return false;
    }

    long int actualHead; 
    ERL_NIF_TERM head;
    ERL_NIF_TERM tail;
    ERL_NIF_TERM currentList = listTerm;

	// O(n), scorre tutta la lista
    for (unsigned int i = 0; i < length; ++i) {
        if (!enif_get_list_cell(env, currentList, &head, &tail)) {
            return false;
        }
        currentList = tail;
        if (!enif_get_long(env, head, &actualHead)) { // prende l'elemento della lista (è double, scorre tutta la lista)
            return false;
        }
        result.push_back(actualHead);
    }

    return true;
}


// Funzione iterativa per calcolare la somma dei numeri da 1 a N
// dichiarare la funzione static per limitare l'accesso a funzioni che non devono essere esposte
// all'esterno del modulo
static ERL_NIF_TERM list_sum_iterative_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {

    std::vector<long int> a;

    if (!fillVector(env, argv[0], a)) {
        return enif_make_badarg(env);
    }

	//creazione dell'array per i risultati da restituire
    ERL_NIF_TERM results[a.size()];

    for(int i=0; i < a.size() ;++i){
        long int  sum = 0;
        for (int j = 1; j <= a[i]; j++) {
            sum += j;
        }

        ERL_NIF_TERM  temp = enif_make_long(env, sum);
        // if (!enif_make_long(env, sum)) {
        //     return enif_make_badarg(env);
        // }
        results[i] = temp;
    }

    // ERL_NIF_TERM list = enif_make_list_from_array(env, results, a.size());
    ERL_NIF_TERM list = enif_make_list_from_array(env, results , a.size());

    return list;
}

// Definizione dei metodi NIF
static ErlNifFunc nif_funcs[] = {
    {"list_sum_iterative_nif", 1, list_sum_iterative_nif}
};

// Funzione di caricamento del modulo NIF
ERL_NIF_INIT(Elixir.SpeedSum, nif_funcs, NULL, NULL, NULL, NULL)
