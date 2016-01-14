class AddAttachmentAvatarToCasts < ActiveRecord::Migration
  def self.up
    change_table :casts do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :casts, :avatar
  end
end
