class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # guest user (not logged in)
    @user = user.user if user.instance_of? Artist

    if @user.guest?
      can :read, Wallsticker
      can :create, User
    else
      profiles
      wallstickers
      show_order_process
      update_order_process
    end
  end

  def profiles
    can :read,   User, :id => @user.id
    can :update, User, :id => @user.id

    if @user.artist?
      can :update, Artist, :artist_id => @user.artist.id
    end
  end

  def wallstickers
    can :read, Wallsticker

    if @user.artist?
      can :create, Wallsticker do |w|
        w.artist == @user.artist
      end
      can :update, Wallsticker, :artist_id => @user.artist.id
    end
  end

  def show_order_process
    can :show_order_process, Order, :user_id => @user.id

    if @user.printer?
      # TODO: only allow if @user is the Printer responsible for order
      can :show_order_process, Order
    end
  end

  def update_order_process
    can :update_order_process, Order, :state => 'waiting_confirm_address_info', :user_id => @user.id
    can :update_order_process, Order, :state => 'waiting_redirect_to_payment_gateway', :user_id => @user.id

    if @user.printer?
      can :update_order_process, Order, :state => 'waiting_acceptance_by_printer'

      # TODO: only allow if @user is the Printer responsible for order
      can :update_order_process, Order, :state => 'waiting_complete_printing'

      # TODO: only allow if @user is the Printer responsible for order
      can :update_order_process, Order, :state => 'waiting_shipping_package'
    end
  end
end
