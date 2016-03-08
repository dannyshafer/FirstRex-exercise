class CreateBaseUsers < ActiveRecord::Migration
  def change
    create_table :base_users do |t|
      t.string :current_month_engagement
      t.string :previous_month_engagement
      t.string :current_month_engagement_score
      t.string :previous_month_engagement_score
      t.string :role
      t.string :other

      t.timestamps null: false
    end
  end
end
