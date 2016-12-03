class CoordinateConverter
  
  BOARD_MAP = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7
  }
  
  def self.convert_input(ary_input)
    ary_input.map! do |elem|
      elem[0] = BOARD_MAP["#{elem[0]}"]
      elem[1] = (elem[1].to_i - 8).abs
      elem = [elem[1], elem[0]]
    end
  end
end