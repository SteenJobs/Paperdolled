class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
         
  mount_uploader :picture, PictureUploader
  
  has_many :scenarios
  

                
  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validate  :picture_size
  
         
         
  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
     existing_user = self.where(email: auth.info.email).first
     existing_user.provider = auth.provider
     existing_user.uid = auth.uid
     existing_user.remote_picture_url = auth.info.image if existing_user.picture.blank?
    else
      existing_user = self.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.remote_picture_url = auth.info.image
      end
    end
    existing_user
  end 
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  # Returns search query
  def self.search(params)
    where("(UPPER(first_name) LIKE ?) OR (UPPER(last_name) LIKE ?)", "%#{params.upcase}%", "%#{params.upcase}%") 
  end

  # Find user responses for scenarios
  def self.list_answers(user)
	  user.scenarios.limit(2).reverse.map do |scenario| 
		  scenario.answers.map do |answer|
        options = Option.all.find_by(id: answer.option_id)
        responses = options.possible_response if !options.nil?
      end
		end
  end 


  
  private
  
  # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end

