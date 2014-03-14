class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :apt_id
      t.date :created_date
      t.text :review
      t.integer :overall_rating

      t.timestamps
    end
  end
end
