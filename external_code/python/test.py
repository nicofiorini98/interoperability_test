import sys

while True:
    # Leggi dati da stdin
    line = sys.stdin.readline().strip()
    
    # Se la linea è vuota, interrompi il ciclo
    if not line:
        break
    
    # Scrivi la linea ricevuta su stdout
    sys.stdout.write(line.upper() + "\n")
    sys.stdout.flush()