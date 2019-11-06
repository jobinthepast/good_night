class RenameClockedInsToSleeps < ActiveRecord::Migration[5.2]
  def change
    rename_table :clocked_ins, :sleeps
  end
end
