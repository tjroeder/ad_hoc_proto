# Record object, to log transactions and track total record totals and user balances.

class Record
  attr_reader :record_type, :timestamp, :user_id, :dollar_amount
  @@total_credit = 0.0
  @@total_debit = 0.0
  @@total_autopays_started = 0
  @@total_autopays_ended = 0
  @@user_balances = Hash.new(0)
  
  def initialize(record_type, timestamp, user_id, dollar_amount = nil)
    @record_type              = record_type
    @timestamp                = timestamp
    @user_id                  = user_id
    @dollar_amount            = dollar_amount
    @@total_credit            += record_type == 0 ? dollar_amount : 0.0
    @@total_debit             += record_type == 1 ? dollar_amount : 0.0
    @@total_autopays_started  += record_type == 2 ? 1 : 0
    @@total_autopays_ended    += record_type == 3 ? 1 : 0
    self.add_user_credit_debit(record_type, user_id, dollar_amount)
  end

  class << self
    def total_credit
      @@total_credit
    end

    def total_debit
      @@total_debit
    end
    
    def total_autopays_started
      @@total_autopays_started
    end
    
    def total_autopays_ended
      @@total_autopays_ended
    end

    def user_balance(user_id)
      @@user_balances.fetch(user_id)
    end
  end

  private
  # Add user credit and debit amount from record to class variable user_balances hash
  def add_user_credit_debit(record_type, user_id, dollar_amount)
    @@user_balances[user_id] += dollar_amount if record_type == 0
    @@user_balances[user_id] -= dollar_amount if record_type == 1
  end
end
