import time

# Funzione utilizzando un ciclo per calcolare la somma dei numeri da 1 a N
def sum_iterative(n):
    sum = 0
    for i in range(1, n+1):
        sum += i
    return sum

# Funzione per eseguire il test di velocità
def speed_test(n):
    # Misura il tempo di esecuzione della funzione sum_iterative
    start_iterative = time.time() * 1e6
    result = sum_iterative(n)
    end_iterative = time.time() * 1e6
    time_iterative = end_iterative - start_iterative

    print("Tempo di esecuzione per sum_iterative:", time_iterative, "microsecondi")

def main():
    n = 1000000
    speed_test(n)

if __name__ == "__main__":
    main()

# Tempo di esecuzione per sum_iterative: 50538.5 microsecondi