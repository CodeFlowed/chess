class AddDefaultValueToActiveColumnInPiecesTable < ActiveRecord::Migration
  def up
    change_column_default :pieces, :active, 1
  end

  def down
    change_column :pieces, :active
  end
end
