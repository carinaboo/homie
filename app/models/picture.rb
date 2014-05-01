# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  apt_id             :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Picture < ActiveRecord::Base
  belongs_to :apartment, class_name: 'Apartment', foreign_key: 'apartment_id'
end
