# from effbot.org/zone/effnews-1.htm

import asyncore
import string, socket

class async_http(asyncore.dispatcher_with_send):
    # asynchronous http client

    def __init__(self, host, path):
        asyncore.dispatcher_with_send.__init__(self)

        self.host = host
        self.path = path

        self.header = None

        self.data = ""

        self.create_socket(socket.AF_INET, socket.SOCK_STREAM)
        self.connect((host, 80))

    def handle_connect(self):
        # connection succeeded; send request
        self.send(
                "GET %s HTTP/1.0\r\nHost: %s\r\n\r\n" %
                (self.path, self.host)
                )

    def handle_expt(self):
        # connection failed
        self.close()

    def handle_read(self):
        # deal with incoming data
        data = self.recv(2048)
        
        if not self.header:
            # check if we have a full header
            self.data = self.data + data
            try:
                i = string.index(self.data, "\r\n\r\n")
            except ValueError:
                return # no empty line; continue
            self.header = self.data[:i+2]
            print self.host, "HEADER"
            print
            print self.header
            data = self.data[i+4:]
            self.data = ""

        if data:
            print self.host, "DATA", len(data)

    def handle_close(self):
        self.close()
