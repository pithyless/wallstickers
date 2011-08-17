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
    before_level_up
    valid?
  end

  def level_up!
    prepare_level_up
    before_level_up
    self.status = self.future_status
    self.save!
  end

  private

  def status_at_least?(status)
    # TODO: need to return true for previous states!
    status == self.status
  end

  def before_level_up
    case self.status
    when :waiting_callback_from_payment_gateway
      self.paid_at = Time.now
    when :waiting_complete_printing
      self.printed_at = Time.now
    end
  end

  # Warning: prepare_level_up may be called more than once on the same
  #          object. Code appropriately.
  #
  # TODO: confirm this usage of singleton validations is kosher
  #
  def prepare_level_up
    if status_at_least? :waiting_confirm_address_info
      class << self
        validates_presence_of :billing_address
        validates_associated  :billing_address
        validates_associated  :shipping_address
      end
    end

    if status_at_least? :waiting_callback_from_payment_gateway
      class << self
        validates_presence_of :paid_at
      end
    end

    if status_at_least? :waiting_complete_printing
      class << self
        validates_presence_of :printed_at
      end
    end

    # TODO: missing validations:
    # :waiting_redirect_to_payment_gateway
    # :waiting_acceptance_by_printer
    # :waiting_shipping_package
    # :finished
  end
end
