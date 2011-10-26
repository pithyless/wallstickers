class ArtistRegistration
  include ActiveModel::Validations

  attr_accessor :username, :bio

  validates_presence_of :username
  validates_presence_of :bio
  validate :user_is_valid

  def initialize(user, params = {})
    @user = user
    if params[:artist_registration]
      @username = params[:artist_registration][:username]
      @bio = params[:artist_registration][:bio]
    end
  end

  def user_is_valid
    @user.username = @username
    unless @user.valid?
      errors.add(:username, @user.errors.messages[:username].first)
    end
  end

  def persisted?
    false
  end

  def to_key
    nil
  end

  def save
    if valid?
      artist = Artist.new
      artist.user = @user
      artist.bio   = @bio

      @user.save!
      artist.save
    end
  end
end
