class CreateBaseUsers < ActiveRecord::Migration
  def change
    create_table :base_users do |t|
      t.integer :current_month_engagement
      t.integer :previous_month_engagement
      t.integer :current_month_engagement_score
      t.integer :previous_month_engagement_score
      t.string :role
      t.string :other

      t.timestamps null: false
    end
  end
end
