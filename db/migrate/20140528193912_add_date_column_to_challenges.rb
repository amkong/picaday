class AddDateColumnToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :date, :timestamp
  end
end
