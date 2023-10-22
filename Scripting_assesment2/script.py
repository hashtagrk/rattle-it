
import ssl
import socket
import datetime

def check_ssl_certificate_expiry(domain, port):
    try:
        context = ssl.create_default_context()
        with socket.create_connection((domain, port)) as sock:
            with context.wrap_socket(sock, server_hostname=domain) as ssock:
                cert = ssock.getpeercert()
                expiry_date = cert['notAfter']
                expiry_datetime = datetime.datetime.strptime(expiry_date, "%b %d %H:%M:%S %Y %Z")
                current_datetime = datetime.datetime.now()
                if current_datetime > expiry_datetime:
                    return f"The SSL certificate for {domain}:{port} has expired."
                else:
                    return f"The SSL certificate for {domain}:{port} is valid until {expiry_datetime}."
    except Exception as e:
        return f"An error occurred: {str(e)}"

if __name__ == "__main__":
    domain = input("Enter the domain: ")
    port = int(input("Enter the port: "))
    result = check_ssl_certificate_expiry(domain, port)
    print(result)