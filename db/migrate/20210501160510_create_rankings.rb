class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.string :uid
      t.string :tweetsperday

      t.timestamps
    end
  end
end
