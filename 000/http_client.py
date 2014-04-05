# from effbot.org/zone/effnews-1.htm

import asyncore
import socket, time
import StringIO
import urlparse
from email.message import Message

class async_http(asyncore.dispatcher_with_send):
    # asynchronous http client

    def __init__(self, host, port, path, consumer):
        asyncore.dispatcher_with_send.__init__(self)

        self.host = host
        self.port = port
        self.path = path

        self.consumer = consumer
        self.status = None
        self.header = None

        self.bytes_in = 0
        self.bytes_out = 0

        self.data = ""

        self.create_socket(socket.AF_INET, socket.SOCK_STREAM)
        self.connect((host, port))

    def handle_connect(self):
        # connection succeeded
        text = "GET %s HTTP/1.0\r\nHost: %s\r\n\r\n" % (self.path, self.host)
        self.send(text)
        self.bytes_out = self.bytes_out + len(text)

    def handle_expt(self):
        # connection failed; notify consumer
        self.close()
        self.consumer.http_failed(self)

    def handle_read(self):

        data = self.recv(2048)
        self.bytes_in = self.bytes_in + len(data)

        if not self.header:
            # check if we've seen a full header

            self.data = self.data + data
            header = self.data.split("\r\n\r\n", 1)
            if len(header) <= 1:
                return
            header, data = header

            # parse header
            fp = StringIO.StringIO(header)
            self.status = fp.readline().split(" ", 2)
            self.header = Message(fp)

            self.data = ""

            self.consumer.http_header(self)

            if not self.connected:
                return # channel was closed by consumer

        if data:
            self.consumer.feed(data)

    def handle_close(self):
        self.consumer.close(self)
        self.close()

def do_request(uri, consumer):

    # turn the uri into a valid request
    scheme, host, path, params, query, fragment = urlparse.urlparse(uri)
    assert scheme == "http", "only supports HTTP requests"
    try:
        host, port = host.split(":", 1)
        port = int(port)
    except (TypeError, ValueError):
        port = 80 # default port
    if not path:
        path = "/"
    if params:
        path = path + ";" + params
    if query:
        path = path + "?" + query

    return async_http(host, port, path, consumer)

