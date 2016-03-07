

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
         
  mount_uploader :picture, PictureUploader
  
  has_many :scenarios
  has_many :outfits
  has_many :authentications
  

                
  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validate  :picture_size
  
         
  def apply_omniauth(auth)
    self.email = auth.email
    self.remote_picture_url = auth.info.image if self.picture.blank?
    self.first_name = auth.info.first_name
    self.last_name = auth.info.last_name
    authentications.build(provider: auth.provider, uid: auth.uid, token: auth.extension.token)
  end       

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      existing_user = self.where(email: auth.info.email).first
      existing_user.provider = auth.provider
      existing_user.uid = auth.uid
      existin_user.remote_picture_url = auth.info.image if existing_user.picture.blank?
    else
      existing_user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name   # assuming the user model has a name
        user.last_name = auth.info.last_name
        user.remote_picture_url = auth.info.image # assuming the user model has an image
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
    # responses = []
    sub_responses = {}
	  scenario = user.scenarios.order("created_at").last
    if !scenario.nil?
      sub_responses["Event"] = scenario.answers.first.option.event.dress_me_for
		  scenario.answers.map do |answer|
        #sub_responses << options.possible_response if !options.nil?
        #response = options.possible_response if !options.nil?
        if !answer.option_id.nil?
          options = Option.all.find_by(id: answer.option_id)
          case options.question_type
          when "And:"
            sub_responses["And"] = options.possible_response if !options.nil?
          when "Also:"
            sub_responses["Also"]= options.possible_response if !options.nil?
          when "With:"
            sub_responses["With"] = options.possible_response if !options.nil?
          end
        end
        if answer.type_in.present?
            sub_responses["Other"] = answer.type_in
        end
        if answer.date.present?
            sub_responses["Date"] = answer.date
        end
      end
    end
      #responses << sub_responses
		
    #responses
    sub_responses.default = "-----"
    #responses = []
    #responses << sub_responses
    return sub_responses
  end 


  
  private
  
  # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end

