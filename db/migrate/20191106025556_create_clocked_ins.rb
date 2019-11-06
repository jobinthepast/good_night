class CreateClockedIns < ActiveRecord::Migration[5.2]
  def change
    create_table :clocked_ins do |t|
      t.datetime :moment
      t.string :kind
      t.integer :user_id

      t.timestamps
    end
  end
end
