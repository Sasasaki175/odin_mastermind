require_relative 'lib/code_pick'

class MasterMind
  def game_start
    puts 'Do you want to play as Codebreaker or Codemaker.'
    puts "Input Codebreaker: 'b' or Codemaker: 'm'"

    loop do
      @player_role = gets.chomp
      break if ['b', 'm'].include?(@player_role)
      puts 'Invalid input please try again.'
    end

    if @player_role == 'b'
      @secret_code = CodePick.new.random_pick
    else
      puts 'Choose 4 pick colors from Blue, Green, Orange, Purple, Red, Yellow and concatenate the initials as secret code. e.g. bggr, rbrp, yogp.'
      @secret_code = CodePick.new.get_player_input
    end

    play_game
  end

  private

  def play_game
    guesses_left = 10

    if @player_role == 'b'
      puts 'Choose 4 pick colors from Blue, Green, Orange, Purple, Red, Yellow and concatenate the initials. e.g. bggr, rbrp, yogp.'
    end
    
    #You can guess the code 10 times until you get it correct or game over
    10.times do
      @breaker_pick = CodePick.new.get_player_input
      guesses_left -= 1
      puts "Correct position: #{match_chr(@secret_code, @breaker_pick)} Include number: #{include_chr(@secret_code, @breaker_pick)}"
      break if @secret_code == @breaker_pick
      puts "Guesses left: #{guesses_left} Try again."
    end

    did_breaker_win
  end

  #Compare two strings and return number of characters that match including position
  def match_chr(string_a, string_b)
    4.times.count { |i| string_a[i] == string_b[i] }
  end

  #Count and return number of shared characters 
  def include_chr(string_a, string_b)
    inclusion = 0
    for chr in string_b.chars.uniq
      inclusion += [string_a.count(chr), string_b.count(chr)].min
    end
    inclusion
  end

  def did_breaker_win
    if @secret_code == @breaker_pick
      puts "You win!"
    else
      puts "You lose"
    end
  end
end

new_game = MasterMind.new
new_game.game_start