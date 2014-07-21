class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :subject, null: false
      t.text :text, null: false
      t.string :user_name, null: false
      t.timestamps
    end
  end
end
