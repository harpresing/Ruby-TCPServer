# A skeleton TCPserver
$LOAD_PATH << File.dirname(__FILE__)
require 'socket'
require "lib/threadpool.rb"

class Server

  def initialize(host,port)
    @host=host
    @port=port
    @descriptors=Array.new #Stores all client sockets and the server socket
    @clientName=Array.new
    @serverSocket= TCPServer.open(@host,@port)
    @descriptors.push(@serverSocket)
    @client
    @threadPool=Thread.pool(4) #There can be a maximum of 4 threads at a time
    @sock_domain 
    @remote_port 
    @remote_hostname 
    @remote_ip
    @StudentID=ARGV[2]||152
  end
  
  def welcome
    @sock_domain, @remote_port, @remote_hostname, @remote_ip = @client.peeraddr
    puts "log: Connection from #{@remote_ip} at port #{@remote_port}"
    
    flag=checkname
      if flag==1 
        checkname
      end
  end
  
  def chatRoom
  end
  

  def servJoinReq
    i=0;
    join_details=Array.new    
    while (i<4)
        input=@client.gets.chomp
        join_details[i]=input.slice((input.index(':')+1)..input.length)
        i+=1
    end
    chatRoom

    @client.puts "JOINED_CHATROOM:#{join_details[0]}\nSERVER_IP:#{@host}\nPORT:#{@port}\nROOM_REF:\nJOIN_ID:\n"
  end


  def checkname #checks if username is available
    flag=0
    input=@client.gets.chomp
      @clientName.each do |name| #If username is already taken, flag is set to 1
        if name==input              
          flag=1
        end
      end
      if flag==0
        @clientName.push(input)
        @client.puts "Success"
        puts "log: Username #{input} created for client #{@remote_port}"
      else
        @client.puts "Username taken, try something else.."
      end
      return flag
  end


    def new_Connection
      while true
      input=@client.gets
      puts "log: got input from client"
      puts "From Client: #{input}"
      handle_Connection(input)
      end
  end

  def handle_Connection(input)
    if input[0,4]=="HELO"
      @client.puts "#{input}IP:#{@host}\nPort:#{@port}\nStudentID:#{@StudentID}\n"
    elsif input=="KILL_SERVICE\n"
      terminate
    else
      @client.puts "Invalid Input \n"
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
      exit
  end

  
  def run
    puts "Server running on Port #{@port} ..."
    while true
      @threadPool.process {
      @client=@serverSocket.accept 
      @descriptors.push(@client)
	    welcome
      servJoinReq
      new_Connection
      }
    end
  end
end

if _FILE_=$0

server = Server.new(ARGV[0]||"Localhost",ARGV[1]||5000)
server.run()

end

