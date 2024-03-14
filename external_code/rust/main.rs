use std::time::{Instant};

// Funzione utilizzando un ciclo per calcolare la somma dei numeri da 1 a N
fn sum_iterative(n: i64) -> i64 {
    let mut sum = 0;
    for i in 1..=n {
        sum += i;
    }
    sum
}

// Funzione per eseguire il test di velocità
fn speed_test(n: i64) {
    // Misura il tempo di esecuzione della funzione sum_iterative
    let start_iterative = Instant::now();
    let result = sum_iterative(n);
    let end_iterative = Instant::now();
    let time_iterative = end_iterative.duration_since(start_iterative).as_micros();

    println!("Tempo di esecuzione per sum_iterative: {} microsecondi, result: {}", time_iterative,result);
}

fn main() {
    let n = 1_000_000;
    speed_test(n);
}
