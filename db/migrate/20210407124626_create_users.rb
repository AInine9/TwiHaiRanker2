class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :nickname
      t.string :name
      t.integer :statuses_count
      t.datetime :registered_at
    end
  end
end
