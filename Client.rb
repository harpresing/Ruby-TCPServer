require 'socket'

s = TCPSocket.new("localhost",420)
puts "log: Starting Session \n"



while !(s.closed?) && (LineFromServer=s.gets)
	puts "From Server: #{LineFromServer}"
	puts "Say something to Server"
	s.puts $stdin.gets
end

