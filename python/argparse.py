import argparse
import hashlib
import hmac
from http.server import HTTPServer, BaseHTTPRequestHandler
import json
import pprint
import os
import sys

# It's not recommended to store the key within the code. Following
# http://12factor.net/config, we'll store this in the environment.
# Note that the key must be a bytes object.
HOOK_SECRET_KEY = os.environb[b'HOOK_SECRET_KEY']


class GithubHookHandler(BaseHTTPRequestHandler):
    """Base class for webhook handlers.

    Subclass it and implement 'handle_payload'.
    """
    def _validate_signature(self, data):
        sha_name, signature = self.headers['X-Hub-Signature'].split('=')
        if sha_name != 'sha1':
            return False

        # HMAC requires its key to be bytes, but data is strings.
        mac = hmac.new(HOOK_SECRET_KEY, msg=data, digestmod=hashlib.sha1)
        return hmac.compare_digest(mac.hexdigest(), signature)

    def do_POST(self):
        data_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(data_length)

        if not self._validate_signature(post_data):
            self.send_response(401)
            return

        payload = json.loads(post_data.decode('utf-8'))
        self.handle_payload(payload)
        self.send_response(200)


class MyHandler(GithubHookHandler):
    def handle_payload(self, json_payload):
        """Simple handler that pretty-prints the payload."""
        print('JSON payload')
        pprint.pprint(json_payload)


if __name__ == '__main__':
    argparser = argparse.ArgumentParser(description='Github hook handler')
    argparser.add_argument('port', type=int, help='TCP port to listen on')
    args = argparser.parse_args()

    server = HTTPServer(('', args.port), MyHandler)
    server.serve_forever()