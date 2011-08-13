class Order < ActiveRecord::Base
  STATUS_TRANSITIONS = {
    :initial => :waiting_confirm_address_info,
    :waiting_confirm_address_info => :waiting_redirect_to_payment_gateway,
    :waiting_redirect_to_payment_gateway => :waiting_callback_from_payment_gateway,
    :waiting_callback_from_payment_gateway => :waiting_acceptance_by_printer,
    :waiting_acceptance_by_printer => :waiting_complete_printing,
    :waiting_complete_printing => :waiting_shipping_package,
    :waiting_shipping_package => :finished,
    :finished => nil
  }

  def future_status
    STATUS_TRANSITIONS.fetch(self.status) { fail "Missing state transition: #{self.status}" }
  end

  def can_level_up?
    prepare_level_up
    valid?
  end

  def level_up!
    prepare_level_up
    self.status = self.future_status
    self.save!
  end

  private

    # Warning: prepare_level_up may be called more than once on the same
    #          object. Code appropriately.
    def prepare_level_up
      case status
      when :waiting_confirm_address_info
        class << self
          validates_presence_of :billing_address
          validates_associated  :billing_address
          validates_associated  :shipping_address # can be missing
        end
      when :waiting_redirect_to_payment_gateway
        # TODO
      when :waiting_callback_from_payment_gateway
        # TODO
      when :waiting_acceptance_by_printer
        # TODO
      when :waiting_complete_printing
        # TODO
      when :waiting_shipping_package
        # TODO
      when :finished
        # TODO
      else
        fail "Unknown state transition: #{status}"
      end
    end
end
