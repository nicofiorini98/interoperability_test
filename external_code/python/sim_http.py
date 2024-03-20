import requests
import threading

# Function to send an HTTP GET request
def send_get_request(url,i):
    response = requests.get(url)
    if response.status_code == 200:
        print(f"Request successful: {i}")
    else:
        print(f"Request failed with status code {response.status_code}")

# Function to simulate n HTTP GET requests concurrently
def simulate_http_requests(url, n):
    # Start n threads, each sending a GET request
    threads = []
    for i in range(n):
        thread = threading.Thread(target=send_get_request, args=(url,i))
        thread.start()
        threads.append(thread)
    
    # Wait for all threads to finish
    for thread in threads:
        thread.join()

# URL to send requests to
url = "http://localhost:8080/"

# Simulate n HTTP GET requests concurrently
simulate_http_requests(url, 10000)
