require_relative 'lib/secret_code'
require_relative 'lib/player_pick'

class MasterMind
  def game_start
    @secret_code = SecretCode.new.random_pick
    play_game
  end

  private

  def play_game
    guesses_left = 10

    puts 'Choose 4 pick colors from Blue, Green, Orange, Purple, Red, Yellow and concatenate the initials. e.g. bggr, rbrp, yogp.'
    
    10.times do
      @player_pick = PlayerPick.new.get_player_input
      guesses_left -= 1
      puts "Correct position: #{match_chr(@secret_code, @player_pick)} Include number: #{include_chr(@secret_code, @player_pick)}"
      break if @secret_code == @player_pick
      puts "Guesses left: #{guesses_left} Try again."
    end

    did_player_win
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

  def did_player_win
    if @secret_code == @player_pick
      puts "You win!"
    else
      puts "You lose"
    end
  end
end

new_game = MasterMind.new
new_game.game_start