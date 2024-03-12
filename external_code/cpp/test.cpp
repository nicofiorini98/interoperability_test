#include <iostream>

int main() {
  std::string line;
  while (true) {
    // Leggi dati da stdin
    std::getline(std::cin, line);

    // Se la linea è vuota, interrompi il ciclo
    if (line.empty()) {
      break;
    }

    // Scrivi la linea ricevuta su stdout in maiuscolo
    for (char &c : line) {
      c = std::toupper(c);
    }
    std::cout << line << std::endl;
  }
  return 0;
}