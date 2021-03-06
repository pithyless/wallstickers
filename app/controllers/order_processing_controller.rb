class OrderProcessingController < ApplicationController
  before_filter :find_order, :except => [:printer_orders]

  def printer_orders
    # TODO: better permissions / authorize!
    raise not_found unless current_user.printer?

    @printer = current_user.printer
    @publisher = @printer.publisher

    @pending_orders = @publisher.pending_orders
    @current_orders = @publisher.current_orders
    @finished_orders = @publisher.finished_orders
  end

  def show
    authorize! :show_order_process, @order

    case @order.status
    when :waiting_confirm_address_info
      @order.billing_address  = Address.new
      @order.shipping_address = Address.new
    end

    render_status_page(@order.status)
  end

  def update
    authorize! :update_order_process, @order

    unless params[:update_status] == @order.status.to_s
      fail "Mismatched controller state: #{params[:update_status]} vs #{@order.status}"
    end

    if :waiting_confirm_address_info == @order.status
      # TODO: limit params to :billing_address_attributes and :shipping_address_attributes
      # TODO: make shipping_address form optional!
      @order.update_attributes(params[:order])
    end

    case @order.status
    when :waiting_redirect_to_payment_gateway
      @order.level_up!
      @order.level_up!  # TODO - callback + verification
      redirect_to show_order_progress_path(@order)
    else
      if @order.can_level_up?
        @order.level_up!
        redirect_to show_order_progress_path(@order)
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
