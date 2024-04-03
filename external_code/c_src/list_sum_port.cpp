#include <algorithm>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

//Funzione che prende in input una stringa
//di interi separati da un delimitatore e restituisce un vector di interi
std::vector<long int> tokenizeToIntVector(const std::string &str,
                                          char delimiter) {
  std::vector<long int> tokens;
  std::stringstream ss(str);
  std::string token;
  while (std::getline(ss, token, delimiter)) {
    tokens.push_back(
        std::stol(token)); // Convert token to integer and add to vector
  }
  return tokens;
}

int main() {
  std::string line;
  // Ascolta lo standard input line by line
  while (std::getline(std::cin, line)) {

    char delimiter = ',';

    std::vector<long> numbers = tokenizeToIntVector(line, delimiter);
    std::vector<long> results;

    for (auto &n : numbers) {
      long sum = 0;
      for (int i = 0; i <= n; i++) {
        sum += i;
      }
      results.push_back(sum);
    }

	// Stampa sullo standard output una stringa
	// nello stesso formato di ricezione
    for (int i = 0; i < results.size() - 1; i++) {
      std::cout << results[i] << ",";
    }
    std::cout << results[results.size() - 1] << std::endl;
  }

  return 0;
}