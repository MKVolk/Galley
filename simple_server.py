import http.server
import socketserver
import os

PORT = 8000


script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

DIRECTORY = "public"

os.chdir(DIRECTORY)

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving './{DIRECTORY}' at http://localhost:{PORT}")
    httpd.serve_forever()

