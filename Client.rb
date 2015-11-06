require 'socket'


s = TCPSocket.new("localhost",ARGV[0] || 5000)
puts "log: Starting Session \n"



	while !(s.closed?) 
    	puts "Say something to Server"
		l=$stdin.gets
		s.puts l

		if l[0,4]=="HELO"
			puts "From Server: "
			i=0
			while(lineFromServer=s.gets)
			 	puts "#{lineFromServer}"
			 	i+=1
			 	if(i==4)
			 	   break
				end
			end
    	else
	    	lineFromServer=s.gets
	    	puts "From Server: #{lineFromServer}"
    	end
    end






