# A skeleton TCPserver
$LOAD_PATH << File.dirname(__FILE__)
require 'socket'
require "lib/threadpool.rb"

class Server

  def initialize(host,port)
    @host=host
    @port=port
    @socket= TCPServer.open(@host,@port)
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
      client.puts "Goodbye"
      @socket.close
      abort("Goodbye")
    else
      client.puts "Invalid Input \n"
    end
  end
    
  def run
    puts "Server running on Port #{@port} ..."
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

server = Server.new(ARGV[0]||"Localhost",ARGV[1]||5000)
server.run()

end

