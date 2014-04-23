WINNERS = [
	{ name: 'rock', beats: 'scissors', verb: 'crushes' },
	{ name: 'rock', beats: 'lizard', verb: 'crushes' },
	{ name: 'paper', beats: 'rock', verb: 'covers' },
	{ name: 'paper', beats: 'spock', verb: 'disproves' },
	{ name: 'scissors', beats: 'paper', verb: 'cuts' },
	{ name: 'scissors', beats: 'lizard', verb: 'decapitates' },
	{ name: 'lizard', beats: 'spock', verb: 'poisons' },
	{ name: 'lizard', beats: 'paper', verb: 'eats' },
	{ name: 'spock', beats: 'scissors', verb: 'smashes' },
	{ name: 'spock', beats: 'rock', verb: 'vaporizes' }
]

GESTURES = WINNERS.map { |g| g[:name]}.uniq

def winner(player_gesture, computer_gesture)
	p_beats = WINNERS.select { |g| g[:name] == player_gesture }.map { |g| g[:beats]}
	c_beats = WINNERS.select { |g| g[:name] == computer_gesture }.map { |g| g[:beats]}
	if p_beats.include?(computer_gesture)
		:player
	elsif c_beats.include?(player_gesture)
		:computer
	else
		return :tie
	end
end

def verb(g_win_name, g_lose_name)
	winner = WINNERS.select {
		|g| g[:name] == g_win_name && g[:beats] == g_lose_name
	}[0][:verb]
end

def output_prompt
	puts "Select a gesture: "
	GESTURES.each_with_index { |g, i|
		puts "#{i + 1}) #{g}"
	}
end

tries = 0
wins = 0
losses = 0

loop {
	tries += 1
	output_prompt
	input = gets.chomp.to_i
	if input > GESTURES.size || input < 1
		puts "incorrect input"
		next
	end

	player_gesture = GESTURES[input - 1]
	computer_gesture = GESTURES[rand(GESTURES.size - 1)]
	round_winner = winner(player_gesture, computer_gesture)

	if round_winner == :player
		wins += 1
		round_verb = verb(player_gesture, computer_gesture)
		puts "Player wins. #{player_gesture} #{round_verb} #{computer_gesture}."
	elsif round_winner == :computer
		losses += 1
		round_verb = verb(computer_gesture, player_gesture)
		puts "Computer wins. #{computer_gesture} #{round_verb} #{player_gesture}."
	else
		puts "Tie"
	end
}