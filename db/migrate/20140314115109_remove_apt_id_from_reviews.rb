class RemoveAptIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :apt_id, :integer
  end
end
