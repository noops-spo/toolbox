import http.server
import socketserver
import os
import json
from datetime import datetime as dt, timedelta
from urllib.parse import urlparse
from urllib.parse import parse_qs

def checklogs():
  with open("/data/script/log/topologyUpdater_lastresult.json", "rb") as file:
    file.seek(-2, os.SEEK_END)
    while file.read(1) != b'\n':
        file.seek(-2, os.SEEK_CUR) 
    last_line=file.readline().decode()
    last_json = json.loads(last_line)

    datenow = dt.now()
    date_str = last_json["datetime"]
    format = "%Y-%m-%d %H:%M:%S"
    hour1 = timedelta(hours=1)
    datetime_obj = dt.strptime(date_str,format)
    difference = datenow - datetime_obj

    if difference < hour1:
      if last_json["resultcode"] == '204':
        result = "topo_updater 1"
      else:
        result = "topo_updater 0"
    else:
      result = "topo_updater 0"
    return result



class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        result = checklogs()
        self.wfile.write(bytes(result, "utf8"))
        return

handler_object = MyHttpRequestHandler

PORT = 8000
my_server = socketserver.TCPServer(("", PORT), handler_object)
my_server.serve_forever()