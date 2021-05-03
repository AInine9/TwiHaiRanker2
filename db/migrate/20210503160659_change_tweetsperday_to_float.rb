class ChangeTweetsperdayToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :rankings, :tweetsperday, 'float USING CAST(tweetsperday AS float)'
  end
end
