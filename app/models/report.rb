class Report < ApplicationRecord
  belongs_to :driver
  belongs_to :truck
  
  validates  :company_id, presence: true
  validates :branch_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  
  mount_uploader :image, ImageUploader

end
