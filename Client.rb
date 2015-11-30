require 'socket'


s = TCPSocket.new("localhost",ARGV[0] || 5000)
puts "log: Starting Session \n"



	while !(s.closed?) 
    	puts "Say something to Server"
		l=$stdin.gets
		s.puts l

		if l[0,4]=="HELO"
			puts "**************Hello Message**************\n"
			i=0
			while(i<=3)
				lineFromServer=s.gets
			 	puts "#{lineFromServer}"
			 	i+=1
			end
			puts "*****************************************\n"
		elsif l[0,4]=="KILL"
			puts "Terminating Server socket"
    	else
	    	puts "Invalid base message"
    	end
    end






