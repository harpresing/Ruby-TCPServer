# A skeleton TCPserver
require 'socket'
require 'thread/pool'
class Server

  def initialize(host,ip)
    @socket= TCPServer.new(host,ip)
    @threadPool=Thread.pool(4) #There can be a maximum of 4 threads at a time
    @sock_domain 
    @remote_port
    @remote_hostname
    @remote_ip
  end
  
  def welcome(client)
    @sock_domain, @remote_port, @remote_hostname, @remote_ip = client.peeraddr
    puts "log: Connection from #{@remote_ip} at port #{@remote_port}"
    client.puts "Server: Welcome #{@remote_hostname}\n"
  end


  def new_Connection(client)
    while input=client.gets
      puts "log: got input from client"
      puts "From Client: #{input}"
      handle_Connection(input,client)
    end
  end

  def handle_Connection(input,client)
    if input=="Helo text\n"
     client.puts "HELO text IP:[#{@remote_ip}] Port:[#{@remote_port}]\n"
     elsif input=="KILL_SERVICE\n"
     abort
     else
     client.puts "Sorry buddy, not programmed to deal with that input yet\n"
    end
  end
    
  def run
    puts "Starting up server..."
    while true 
      @threadPool.process {
      client=@socket.accept 
	    welcome(client)
      new_Connection(client)
      }
    end
  end
end

if _FILE_=$0

server = Server.new("Localhost", ARGV[0] || 420)
server.run()

end

