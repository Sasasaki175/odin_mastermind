class SecretCode
  PICK_COLORS = %w[b g o p r y].freeze

  #Computer picks 4 random picks
  def random_pick
    Array.new(4) { PICK_COLORS.sample }.join
  end
end
