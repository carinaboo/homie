class RemoveCreatedDateFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :created_date, :date
  end
end
