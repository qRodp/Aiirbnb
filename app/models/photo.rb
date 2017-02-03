class Photo < ActiveRecord::Base
  belongs_to :room
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                            :storage => :cloudinary,
                            :path => ':id/:style/:filename'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/ 
 
  
end
