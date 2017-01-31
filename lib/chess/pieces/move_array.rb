module MoveArray  
  
  private
  
    def row_coordinates(coordinates)
      (0...8).collect {|num| [coordinates[0], num] }
    end
    
    def column_coordinates(coordinates)
      (0...8).collect {|num| [num, coordinates[1]] }
    end
    
    def left_to_right_diagonal_coordinates(coordinates)
      start_cords = [coordinates[0] - coordinates.min, coordinates[1] - coordinates.min]
      if coordinates[0] >= coordinates[1]
        (start_cords[0]...8).collect {|cords| [cords, cords - start_cords[0]] }
      else
        (start_cords[1]...8).collect {|cords| [cords - start_cords[1], cords]}
      end
    end
    
    def right_to_left_diagonal_coordinates(coordinates)
      if coordinates.reduce(:+) < 7
        start_cords = [0, coordinates.reduce(:+)]
      else
        start_cords = [coordinates.reduce(:+) - 7, 7]
      end
      ((start_cords[0]..start_cords[1]).to_a).zip(((start_cords[0]..(start_cords[1])).to_a).reverse)
    end
    
    def pawn_forward(coordinates)
      if self.colour == :white
        [coordinates[0] - 1, coordinates[1]]
      else
        [coordinates[0] + 1, coordinates[1]]
      end
    end
    
    def pawn_diagonal(coordinates)
      if self.colour == :white
        results = []
        move_set = [[-1, -1], [-1, 1]]
        move_set.each do |move|
          results << coordinates.zip(move).map {|x,y| x + y }
        end
        results
      else
        results = []
        move_set = [[1, -1], [1, 1]]
        move_set.each do |move|
          results << coordinates.zip(move).map {|x,y| x + y }
        end
        results
      end
    end

end
