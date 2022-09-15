class AddPhotoToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :photo, :string
    add_column :drivers, :image_cache, :string
  end
end
