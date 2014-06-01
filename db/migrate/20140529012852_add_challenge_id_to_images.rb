class AddChallengeIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :challenge_id, :integer
  end
end
