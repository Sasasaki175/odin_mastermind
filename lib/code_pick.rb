class PlayerPick
  PICK_COLORS = %w[b g o p r y]

  def get_player_input
    loop do
      @player_input = gets.chomp.downcase
      break if valid_player_pick?(@player_input)
      puts 'Invalid input please try again.'
    end

    @player_input
  end

  private

  def valid_player_pick?(pick)
    pick.length == 4 && pick.chars.all? { |chr| PICK_COLORS.include?(chr) }
  end
end