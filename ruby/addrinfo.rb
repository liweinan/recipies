require 'socket'

Addrinfo.tcp("127.0.0.1", 2000).connect do |s|
  p s.recv(50)
end
