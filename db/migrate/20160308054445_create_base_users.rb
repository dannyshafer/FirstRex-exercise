class CreateBaseUsers < ActiveRecord::Migration
  def change
    create_table :base_users do |t|
      t.integer :current_month_engagement, default: 0
      t.integer :previous_month_engagement, default: 0
      t.float :current_month_engagement_score, default: 0
      t.float :previous_month_engagement_score, default: 0
      t.string :role
      t.string :name
      t.string :other

      t.timestamps null: false
    end
  end
end
