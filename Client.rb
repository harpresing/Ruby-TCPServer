require 'socket'

class Client

def initialize(host,port) 
	@s = TCPSocket.new(host, port)
	@clientName
	@chatroom
	puts "log: Starting Session \n"
end

def username
	puts "Enter a username:"
	@clientName= $stdin.gets
	@s.puts @clientName
	answer=@s.gets
	puts answer
	if answer[0,7]!="Success"
		 username
	end
end

def sendJoinRequest
	username
	puts "Enter the name of the chatroom you would like to join"
	@chatroom=$stdin.gets.chomp
	@s.puts "JOIN_CHATROOM:#{@chatroom}\nClient_IP:\nPORT:\nCLIENT_NAME:#{@clientName}"
end

def getJoinResponse
	i=0;
	while i<=4
		puts @s.gets
		i+=1
	end
end

def run
    sendJoinRequest
    getJoinResponse 
	
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





