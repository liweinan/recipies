print("Hello, Martian!")

s = "This is a string with 'quotes' in it"
print(s)

s = '''This is
-------------
Hello, world!
-------------'''

print(s)

s = '\t'
print(s)

import subprocess

res = subprocess.Popen(['uname', '-v'], stdout=subprocess.PIPE)
uname = res.stdout.read().strip()

print(uname)