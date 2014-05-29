class AddChallengeIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :challenge_id, :reference
  end
end
