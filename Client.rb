require 'socket'

class Client

def initialize(host,port) 
	@s = TCPSocket.new(host, port)
	@clientName
	puts "log: Starting Session \n"
end

def join
	puts "username:"
	@clientName= $stdin.gets
	@s.puts @clientName
	answer=@s.gets
	puts answer
	if answer[0,7]!="Success"
		 join
	end
end

def run
   join
	while !(@s.closed?) 
    	puts "Say something to Server"
		l=$stdin.gets
		@s.puts l

		if l[0,4]=="HELO"
			puts "From Server: "
			i=0
			while(lineFromServer=@s.gets)
			 	puts "#{lineFromServer}"
			 	i+=1
			 	if(i==4)
			 	   break
				end
			end
    	else
	    	lineFromServer=@s.gets
	    	puts "From Server: #{lineFromServer}"
    	end
    end
end

end

if _FILE_=$0

client = Client.new(ARGV[0]||"Localhost",ARGV[1]||5000)
client.run()

end





