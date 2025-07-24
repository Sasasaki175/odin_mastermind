class CodePick
  COLORS = %w[b g o p r y].freeze

  #Input code manually
  def get_player_input
    loop do
      @player_input = gets.chomp.downcase
      break if valid_player_pick?(@player_input)
      puts 'Invalid input please try again.'
    end

    @player_input
  end

  #Picks 4 random picks
  def random_pick
    Array.new(4) { COLORS.sample }.join
  end
  
  #Returns 
  def com_pick(match_arr)
    com_pick = match_arr.map { |pick| pick != nil ? pick : COLORS.sample }
    com_pick.join
  end

  private

  def valid_player_pick?(pick)
    pick.length == 4 && pick.chars.all? { |chr| COLORS.include?(chr) }
  end
end