#include "./includeErl/erl_nif.h"
// #include "erl_nif.h"
#include "string.h"



// how to compile
// gcc -fPIC -shared -o elixir_nif.so elixir_nif.c -I $ERL_ROOT/usr/include/

//gcc -o priv/elixir_nif.so -shared -fpic -I$ERL_ROOT/usr/include c_src/elixir_nif.c

static ERL_NIF_TERM hello(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_string(env, "Hello world from  from C!", ERL_NIF_LATIN1);
}

static ErlNifFunc nif_funcs[] =
{
    {"hello", 0, hello}
};

ERL_NIF_INIT(Elixir.ElixirNif,nif_funcs,NULL,NULL,NULL,NULL)