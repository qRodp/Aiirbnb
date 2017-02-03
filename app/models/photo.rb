class Photo < ActiveRecord::Base
  belongs_to :room
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :image, :storage => :cloudinary, :if => lambda{ Rails.env.production?}
  has_attached_file :image, :path => ':id/:style/:filename', :if => lambda{ Rails.env.production?}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/ 
 
  
end
