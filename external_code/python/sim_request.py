import socket
import threading

# function that send message
def send_request(host, port, message):
    # Create a TCP socket
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    try:
        # Connect to the server
        client_socket.connect((host, port))

        # Send the message
        client_socket.sendall(message.encode())

        # Receive the response
        response = client_socket.recv(1024)
        print(f"Response from {host}:{port}: {response.decode()}")

    except Exception as e:
        print(f"Error connecting to {host}:{port}: {e}")

    finally:
        # Close the socket
        client_socket.close()

def simulate_requests(host, port, num_requests, message):
    threads = []
    for _ in range(num_requests):
        t = threading.Thread(target=send_request, args=(host, port, message))
        t.start()
        threads.append(t)
    for thread in threads:
        thread.join()

if __name__ == "__main__":
    host = "localhost"  # Change this to the host you want to connect to
    port = 4040          # Change this to the port you want to connect to
    num_requests = 10    # Change this to the number of requests you want to simulate
    message = "Hello, server!\n"  # Change this to the message you want to send
    print(f"main")

    simulate_requests(host, port, num_requests, message)
