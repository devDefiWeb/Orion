class CreateJoinTableUserAudience < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, index: true, foreign_key: true
      t.references :audience, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
