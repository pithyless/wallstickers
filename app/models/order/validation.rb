class Order < ActiveRecord::Base
  validates :user,           :presence => true
  validates :state,          :presence => true
  validates :balance_pln,    :presence => true, :numericality => true

  before_validation :calculate_balance_pln
  before_validation :set_initial_status, :on => :create
  before_create :generate_token

  def status=(value)
    if value.nil?
      write_attribute :state, nil
    else
      write_attribute :state, value.to_s
    end
  end

  def status
    self[:state].try(:to_sym)
  end

  private

    def set_initial_status
      self.status = :waiting_confirm_address_info
    end

    def generate_token
      # TODO: move this generator to PostgreSQL to avoid race condition
      r = Random.new
      tok = r.rand(10**5...10**6).to_s
      while Order.find_by_token(tok)
        tok = r.rand(10**5...10**6).to_s
      end
      write_attribute :token, tok
    end

    def calculate_balance_pln
      # TODO: this needs to also trigger whenever associated order_items change
      write_attribute :balance_pln, order_items.map{ |i| i.price_pln }.sum
    end
end
