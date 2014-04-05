import http_client, asyncore

class dummy_consumer:
    def http_header(self, client):
        self.host = client.host
        print self.host, repr(client.status)
    def http_failed(self, client):
        self.host = client.host
        print self.host, "failed"
    def feed(self, data):
        self.host = client.host
        print self.host, len(data)
    def close(self, client):
        self.host = client.host
        print self.host, "CLOSE"

URLS = (
        "http://effbot.org/zone/rss.xml",
        "http://www.scripting.com/rss.xml",
        )

for url in URLS:
    http_client.do_request(url, dummy_consumer())

asyncore.loop()
