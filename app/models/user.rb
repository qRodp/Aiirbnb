class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
         
  validates :fullname, presence:true, length: {maximum: 65}
  
  has_many :rooms
  has_many :reservations
  has_many :reviews
      
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                      :default_url => "/assets/default_image.png"            
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/ 

def self.from_omniauth(auth)
  user = User.where(email: auth.info.email).first
  
  if user
    return user
  else
    where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
      u.fullname = auth.info.name
      u.provider = auth.provider
      u.uid = auth.uid
      u.email = auth.info.email
      u.image = auth.info.image
      u.password = Devise.friendly_token[0,20]
    end
  end
end

end
