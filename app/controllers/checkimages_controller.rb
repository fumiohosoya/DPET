class CheckimagesController < ApplicationController
    
    
    def create
      @image = Checkimage.new(image_params)
      @image.save
    end
    
    
    private
    
    def image_params
        params.require(:checkimages).permit(:image)
    end
end
