class Game < ActiveRecord::Base
	belongs_to :user
  has_many :pieces

  after_create :populate_board!

  def populate_board!
    # These are initialized to the white pieces' y coordinates. y2 is for the
    # pawns' y coordinate.
    y = 1
    y2 = 2

    # Create white pieces locations on 1st loop and then 
    # the black pieces locations on the 2nd loop
    2.times do
      # Create 8 pawns                   
      1.upto(8) do |x|
        Pawn.create( :x_position => x,
                     :y_position => y2,
                     :active     => 1,
                     :game_id    => self.id )
      end

      # Create 2 rooks 
      1.step(8, 7) do |x|
        Rook.create( :x_position => x,
                     :y_position => y,
                     :active     => 1,
                     :game_id    => self.id )
      end

      # Create 2 knights
      2.step(7, 5) do |x|
        Knight.create( :x_position => x,
                       :y_position => y,
                       :active     => 1,
                       :game_id    => self.id )
      end

      # Create 2 bishops
      3.step(6, 3) do |x|
        Bishop.create( :x_position => x,
                       :y_position => y,
                       :active     => 1,
                       :game_id    => self.id )
      end

      # Create a queen
      Queen.create( :x_position => 4,
                    :y_position => y,
                    :active     => 1,
                    :game_id    => self.id )

      # Create a king
      King.create( :x_position => 5,
                   :y_position => y,
                   :active     => 1,
                   :game_id    => self.id )

      # Update y and y2 values for the black pieces' y coordinates
      y = 8
      y2 = 7
    end  
  end
end
