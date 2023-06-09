class Report < ApplicationRecord
  belongs_to :driver
  belongs_to :truck
  belongs_to :company
  belongs_to :branch
  
  mount_uploader :image, ImageUploader

end
