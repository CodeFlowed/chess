class Piece < ActiveRecord::Base
	belongs_to :user
  belongs_to :game

	def self.types
		%w(Pawn Rook Knight Bishop Queen King)
	end

  def is_obstructed?(dest_x, dest_y)
      # Get the piece's starting coordinates
      start_x = self.x_position
      start_y = self.y_position

      # Get the difference between the starting and ending x and y coordinates
      delta_x = (start_x - dest_x).abs
      delta_y = (start_y - dest_y).abs

      # Prep x and y incrementors
      increment_x, increment_y = 0

      # Make increment_x go east (1) or west (-1)
      if start_x < dest_x
        increment_x = 1
      else
        increment_x = -1
      end

      # Make increment_y go north (1) or south (-1)
      if start_y < dest_y
        increment_y = 1
      else
        increment_y = -1
      end

      # This function checks the database for a potential obstacle
      def obstacle?(check_x, check_y)
        game.pieces.exists?(:x_position => check_x,
                            :y_position => check_y,
                            :active => 1)   
      end
      
      #--------------------------------------------------
      # Find any obstacles when the destination is on a:
      # - horizontal path
      if start_y == dest_y
        check_x = start_x + increment_x

        while check_x - dest_x != 0 do
          return true if obstacle?(check_x, dest_y) 

          check_x += increment_x
        end

        return false
      #--------------------------------------------------
      # - vertical path
      elsif start_x == dest_x
        check_y = start_y + increment_y

        while check_y - dest_y != 0 do
          return true if obstacle?(dest_x, check_y) 

          check_y += increment_y
        end

        return false
      #--------------------------------------------------
      # - diagonal path
      else
        return "Error: Illegal move" if delta_x != delta_y
       
        check_x = start_x + increment_x
        check_y = start_y + increment_y

        while (check_x - dest_x != 0) && (check_y - dest_y != 0) do
          return true if obstacle?(check_x, check_y) 

          check_x += increment_x
          check_y += increment_y
        end

        return false
      end
  end # of is_obstructed?
end # end class