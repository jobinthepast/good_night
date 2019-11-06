class RenameColumnsInSleeps < ActiveRecord::Migration[5.2]
  def up
    rename_column :sleeps, :moment,   :start_time
    remove_column :sleeps, :kind
    add_column    :sleeps, :end_time, :datetime
    add_column    :sleeps, :length,   :integer
  end

  def down
    rename_column :sleeps, :start_time, :moment
    add_column    :sleeps, :kind,       :string
    remove_column :sleeps, :end_time,   :datetime
    remove_column :sleeps, :length,     :integer
  end
end
