#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Funzione utilizzando un ciclo per calcolare la somma dei numeri da 1 a N
int sum_iterative(int n) {
    int sum = 0;
    for (int i = 1; i <= n; i++) {
        sum += i;
    }
    return sum;
}

// Funzione per eseguire il test di velocità
void speed_test(int n) {
    // Misura il tempo di esecuzione della funzione sum_iterative
    clock_t start_iterative = clock();
	// for (int i=0; i < 1000; i++){
    int result = sum_iterative(n);
	// }
    // int result_iterative = sum_iterative(n);
    clock_t end_iterative = clock();
    double time_iterative = ((double) (end_iterative - start_iterative)) / CLOCKS_PER_SEC;

    printf("Tempo di esecuzione per sum_iterative: %f secondi\n", time_iterative);
}

int main() {
    int n = 1000000;
    speed_test(n);
    return 0;
}
