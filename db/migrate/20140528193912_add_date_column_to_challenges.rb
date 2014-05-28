class AddDateColumnToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :date, :date_time
  end
end
