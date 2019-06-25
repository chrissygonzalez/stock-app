class User < ActiveRecord::Base
    has_many :transactions
    has_many :stocks, through: :transactions

    has_secure_password

    def deduct_from_balance(amount)
        self.balance = self.balance - amount
        self.save
    end
end