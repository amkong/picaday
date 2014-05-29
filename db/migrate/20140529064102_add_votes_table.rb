class AddVotesTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :image
      t.timestamps
    end
  end
end
