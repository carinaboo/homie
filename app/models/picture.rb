# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  apartment_id       :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Picture < ActiveRecord::Base
  belongs_to :apartment, class_name: 'Apartment', foreign_key: 'apartment_id'
  has_attached_file :image, styles: {thumb: "75x75>", small: "500x500>", large: "1200x1200>"}
  #validates_attachment :image, content_type: { content_type: ["photo/jpg", "photo/jpeg", "photo/png"] }
  do_not_validate_attachment_file_type :image
end
