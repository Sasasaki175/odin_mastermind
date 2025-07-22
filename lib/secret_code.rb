class SecretCode
  PICK_COLORS = %w[b g o p r y]

  #Computer picks 4 random picks
  def cpu_pick
    Array.new(4) { PICK_COLORS.sample }
  end
end
