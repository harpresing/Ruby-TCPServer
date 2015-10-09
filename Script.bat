@echo off
START "Server" cmd /k  ruby Server.rb 420
START "Client" cmd /k  ruby Client.rb 
 

