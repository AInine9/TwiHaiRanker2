class RemoveTimestampsFromRanking < ActiveRecord::Migration[6.1]
  def change
    remove_column :rankings, :created_at, :string
    remove_column :rankings, :updated_at, :string
  end
end
