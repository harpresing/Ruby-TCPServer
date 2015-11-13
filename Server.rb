# A skeleton TCPserver
$LOAD_PATH << File.dirname(__FILE__)
require 'socket'
require "lib/threadpool.rb"

class Server

  def initialize(host,port)
    @host=host
    @port=port
    @descriptors=Array.new #Stores all client sockets and the server socket
    @serverSocket= TCPServer.open(@host,@port)
    @descriptors.push(@serverSocket)
    @threadPool=Thread.pool(4) #There can be a maximum of 4 threads at a time
    @sock_domain 
    @remote_port 
    @remote_hostname 
    @remote_ip
    @StudentID=ARGV[2]||152
  end
  
  def welcome(client)
    @sock_domain, @remote_port, @remote_hostname, @remote_ip = client.peeraddr
    puts "log: Connection from #{@remote_ip} at port #{@remote_port}"
  end


  def new_Connection(client)
      while true
      input=client.gets
      puts "log: got input from client"
      puts "From Client: #{input}"
      handle_Connection(input,client)
      end
  end

  def handle_Connection(input,client)
    if input[0,4]=="HELO"
      client.puts "#{input}IP:#{@host}\nPort:#{@port}\nStudentID:#{@StudentID}\n"
    elsif input=="KILL_SERVICE\n"
      terminate
    else
      client.puts "Invalid Input \n"
    end
  end

  def terminate #terminates all socket connections, terminating clients first
    @descriptors.each do |socket|  
      if socket!= @serverSocket
         socket.puts "Goodbye"
         socket.close
      end
    end
      
      puts "Server Shutting down \n"
      @serverSocket.close   
      abort("Goodbye")
  end

  
  def run
    puts "Server running on Port #{@port} ..."
    while true
      @threadPool.process {
      client=@serverSocket.accept 
      @descriptors.push(client)
	    welcome(client)
      new_Connection(client)
      }
    end
  end
end

if _FILE_=$0

server = Server.new(ARGV[0]||"Localhost",ARGV[1]||5000)
server.run()

end

