class Checkimage < ApplicationRecord
  belongs_to :checkitem
  
  mount_uploader :image, ImageUploader

end
