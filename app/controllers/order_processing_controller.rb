class OrderProcessingController < ApplicationController
  before_filter :find_order

  def show
    authorize! :show_order_process, @order

    render_status_page(@order.status)
  end

  def update
    authorize! :update_order_process, @order

    unless params[:update_status] == @order.status
      fail "Mismatched state: #{params[:update_status]}"
    end

    if :waiting_redirect_to_payment_gateway == @order.status
      # TODO - callback + verification
      @order.level_up!
      @order.level_up!
      redirect show_order_progress_path(@order)
    else
      if @order.can_level_up?
        @order.level_up!
        redirect show_order_progress_path(@order)
      else
        render_status_page(@order.status)
      end
    end
  end

  private

    def find_order
      @order = Order.find_by_token(params[:id]) || not_found
    end

    def render_status_page(status)
      status = status.to_s
      if status.start_with?('waiting_')
        render status.sub('waiting_', '')
      elsif 'finished' == status
        render 'finished'
      else
        fail 'Missing status: #{status}'
      end
    end
end
