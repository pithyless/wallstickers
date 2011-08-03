class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # guest user (not logged in)
    @user = user.user if user.instance_of? Artist

    wallstickers
  end

  def wallstickers
    can :read, Wallsticker

    if @user.artist?
      can :create, Wallsticker
      can :update, Wallsticker, :artist_id => @user.artist.id
    end
  end
end
