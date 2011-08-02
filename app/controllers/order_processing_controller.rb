class OrderProcessingController < ApplicationController
  before_filter :find_order

  def show
    status = @order.state.to_s
    if status.start_with?('waiting_')
      render status.sub('waiting_', '')
    elsif 'finished' == status
      render 'finished'
    else
      fail 'Missing status: #{status}'
    end
  end

  def update
    unless params[:update_status] == @order.state
      fail "Mismatched state: #{params[:update_status]}"
    end

    next_url = show_order_progress_path(@order)

    case @order.state_name
    when :waiting_confirm_address_info
      @order.confirmed_address_info!
    when :waiting_redirect_to_payment_gateway
      @order.redirected_to_payment_gateway!
    when :waiting_redirect_to_payment_gateway
      @order.redirected_to_payment_gateway!
      @order.verified_payment_gateway_transaction! # TODO - callback + verification
    when :waiting_acceptance_by_printer
      @order.accepted_by_printer!
    when :waiting_complete_printing
      @order.completed_printing!
    when :waiting_shipping_package
      @order.shipped_package!
    else
      fail "Unkown state: #{@order.state}" # TODO
    end

    redirect_to next_url
  end

  private

  def find_order
    @order = Order.find_by_token(params[:id]) || not_found
  end
end
