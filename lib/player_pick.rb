class PlayerPick
  def get_player_input
    puts 'Choose 4 pick colors from Blue, Green, Orange, Purple, Red, Yellow and concatenate the initials. e.g. bggr, rbrp, yogp.'
    loop do
      player_input = gets.chomp.downcase
      break if valid_player_pick?(player_input)
      puts 'Invalid input please try again.'
    end
    player_input
  end

  private
  
  def valid_player_pick?(pick)
    pick.length == 4 && pick.chars.all? { |chr| PICK_COLORS.include?(chr) }
  end
end