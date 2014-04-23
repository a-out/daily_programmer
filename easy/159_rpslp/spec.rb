require 'rspec'
require_relative './rpslp.rb'

describe 'beats?' do
	it 'takes two gestures, and determines if the first beats the second' do
		beats?('rock', 'scissors').should eq true
		beats?('rock', 'lizard').should eq true
		beats?('paper', 'spock').should eq true
		beats?('spock', 'rock').should eq true
	end
end

describe 'verb' do
	it 'takes two gestures and a gesture list, and determines the verb involved' do
		verb('rock', 'scissors').should eq 'crushes'
		verb('paper', 'spock').should eq 'disproves'
	end
end