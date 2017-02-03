class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  validates :fullname, presence:true, length: {maximum: 65}
  
  has_many :rooms
  has_many :reservations
      
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/assets/default_image.png"
    has_attached_file :avatar, :storage => :cloudinary, :if => lambda{ Rails.env.production?}
    has_attached_file :avatar, :path => ':id/:style/:filename', :if => lambda{ Rails.env.production?}                
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/ 

end
