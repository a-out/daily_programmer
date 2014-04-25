require 'pp'

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

def prompt_input
	puts "Select a gesture: "
	GESTURES.each_with_index { |g, i|
		puts "#{i + 1}) #{g}"
	}
	input = gets.chomp
	if input == 'q'
		input
	elsif input.to_i > GESTURES.size + 1 || input.to_i < 1
		nil
	else
		input.to_i
	end
end

def ai_choice(ai_data)
	max_times_chosen = ai_data.values.max
	# likely choices are simply ones that the player has picked the most
	likely_choices = ai_data.select { |choice, amt| amt == max_times_chosen }.keys

	# if there is more than one possible choice, predict one at random
	predicted = likely_choices[rand(likely_choices.size - 1)]

	# pick a gesture that beats the predicted one
	WINNERS.select { |g| g[:beats] == predicted }[0][:name]
end

def update_player_history(ai_data, p_choice)
	# update count for this choice
	previous_amount = ai_data[p_choice]
	ai_data.merge( {p_choice => previous_amount + 1} )
end

def end_game_stats(won, lost, played)
	puts
	puts "End-game Stats"
	puts "Wins: #{won}"
	puts "Losses: #{lost}"
	puts "Ties: #{played - (won + lost)}"
	puts
end

# main ------------
ai_data = Hash[GESTURES.map { |g| [g, 0] }]
rounds_played = 0
rounds_won = 0
rounds_lost = 0

loop {
	input = prompt_input
	if input == 'q' then break end
	if input.nil?
		puts "Invalid choice."
		next
	end

	rounds_played += 1

	p_choice = GESTURES[input - 1]
	ai_choice(ai_data)
	c_choice = ai_choice(ai_data)

	puts "player chose: #{p_choice}, computer chose: #{c_choice}"
	ai_data = update_player_history(ai_data, p_choice)
	round_winner = winner(p_choice, c_choice)

	if round_winner == :player
		rounds_won += 1
		puts "#{p_choice} #{verb(p_choice, c_choice)} #{c_choice}."
		puts "Player wins."
	elsif round_winner == :computer
		rounds_lost += 1
		puts "#{c_choice} #{verb(c_choice, p_choice)} #{p_choice}."
		puts "Computer wins."
	else
		puts "Tie."
	end

	puts
}

end_game_stats(rounds_won, rounds_lost, rounds_played)