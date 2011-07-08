class ApplicationController < ActionController::Base
  protect_from_forgery

  include Sorcery::Controller::InstanceMethods

  # TODO
  #
  # unless Rails.application.config.consider_all_requests_local
  #   rescue_from Exception, :with => :render_error
  #   rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  #   rescue_from AbstractController::ActionNotFound, :with => :render_not_found
  #   rescue_from ActionController::RoutingError, :with => :render_not_found
  #   rescue_from ActionController::UnknownController, :with => :render_not_found
  #   rescue_from ActionController::UnknownAction, :with => :render_not_found
  # end

  # def render_error exception
  #   Rails.logger.error(exception)
  #   # TODO: HoptoadNotifier.notify(exception)
  #   render :template => "/errors/500.html.erb", :status => 500
  # end

  # def render_not_found(exception=nil)
  #   Rails.logger.error(exception) unless exception.nil?
  #   Rails.logger.error('[4o4]: ' + request.url)
  #   render :template => "errors/404.html.erb", :status => 404
  # end

  protected
  def not_authenticated
    redirect_to :login
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
