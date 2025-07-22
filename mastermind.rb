require_relative 'lib/secret_code'

class MasterMind
  def game_start
    @secret_code = SecretCode.new.cpu_pick
  end
end
