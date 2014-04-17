class AddAttachmentPhotoToApartments < ActiveRecord::Migration
  def self.up
    change_table :apartments do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :apartments, :photo
  end
end
