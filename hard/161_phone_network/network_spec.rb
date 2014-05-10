require_relative 'phone_network.rb'
require 'pp'

describe 'PhoneNetworkGraph' do
   
   before :each do
      @network = PhoneNetworkGraph.new
   end

   describe 'add_connection' do
      it 'adds a new network connection' do
         @network.add_connection('A', 'B')
         @network.add_connection('B', 'C')
         @network.add_connection('A', 'C')
         pp @network
      end
   end


end