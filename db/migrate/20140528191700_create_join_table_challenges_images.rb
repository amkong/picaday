class CreateJoinTableChallengesImages < ActiveRecord::Migration
  def change
    create_join_table :challenges, :images 
  end
end
