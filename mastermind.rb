require_relative 'lib/code_pick'

class MasterMind
  def game_start
    choose_role
    play_game
  end

  private

  def choose_role
    puts 'Do you want to play as Codebreaker or Codemaker.'
    puts "Input 'b': Codebreaker or 'm': Codemaker"

    loop do
      @player_role = gets.chomp

      break if %w[b m].include?(@player_role)

      puts 'Invalid input please try again.'
    end

    maker_pick
  end

  def maker_pick
    if @player_role == 'b'
      @secret_code = CodePick.new.random_pick
    else
      puts 'Choose 4 pick colors from Blue, Green, Orange, Purple, Red, Yellow '
      puts 'and concatenate the initials as secret code. e.g. bggr, rbrp, yogp.'
      @secret_code = CodePick.new.player_input
    end
  end

  def play_game
    @saved_picks = Array.new(4)

    if @player_role == 'b'
      puts 'Choose 4 pick colors from Blue, Green, Orange, Purple, Red, Yellow '
      puts 'and concatenate the initials. e.g. bggr, rbrp, yogp.'
    end
    
    game_loop
    did_breaker_win
  end

  def game_loop
    guesses_left = 10

    # You or the computer can guess the code 10 times
    10.times do
      breaker_pick

      guesses_left -= 1

      puts "Com guess: '#{@breaker_pick}'" if @player_role == 'm'

      puts "Correct position: #{matched_position_count(@secret_code, @breaker_pick)}"
      puts "Correct color: #{matched_color_count(@secret_code, @breaker_pick)}"
      
      @saved_picks = matching_picks(@secret_code, @breaker_pick)

      break if @secret_code == @breaker_pick

      puts "Guesses left: #{guesses_left}"
      puts 'Try again.' if guesses_left.positive?
    end
  end

  def breaker_pick
    @breaker_pick = if @player_role == 'b'
                      CodePick.new.player_input
                    else
                      CodePick.new.com_pick(@saved_picks)
                    end
  end

  # Compare two strings and return number of characters that match including position
  def matched_position_count(string_a, string_b)
    4.times.count { |i| string_a[i] == string_b[i] }
  end

  # Count and return number of shared characters
  def matched_color_count(string_a, string_b)
    inclusion = 0

    string_b.chars.uniq.each do |chr|
      inclusion += [string_a.count(chr), string_b.count(chr)].min
    end

    inclusion
  end

  # Returns an array with the matched color picks and nil
  def matching_picks(string_a, string_b)
    wrong_position_count = matched_color_count(string_a, string_b) - matched_position_count(string_a, string_b)
    matched_picks = 4.times.map { |i| string_a[i] == string_b[i] ? string_a[i] : nil }
    unmatched_code = 4.times.map { |i| string_a[i] == string_b[i] ? nil : string_a[i] }
    unmatched_picks = 4.times.map { |i| string_a[i] == string_b[i] ? nil : string_b[i] }
    saved_colors = unmatched_picks.compact.map { |pick| unmatched_code.include?(pick) ? pick : nil }.shuffle
    return saved_picks = matched_picks.map { |pick| pick.nil? ? saved_colors.pop : pick }
  end

  def did_breaker_win
    if @secret_code == @breaker_pick
      puts @player_role == 'b' ? 'You win!' : 'Com wins!'
    else
      puts @player_role == 'b' ? "You lose. Secret code was '#{@secret_code}'." : 'Com could not figure out the code.'
    end
  end
end

new_game = MasterMind.new
new_game.game_start
