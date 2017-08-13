class Account < ApplicationRecord
    has_many :portfolios, dependent: :delete_all
    validates :name, uniqueness: true
    #after_save :check_suspension
    
    def deposit(amount)
        return if !is_amount_valid(amount)
        b = self.balance + amount
        self.update!(balance: @b)
        return true
    end
    
    def withdraw (amount)
        return if !is_amount_valid(amount)
        if self.balance >= amount
            self.update!(balance: self.balance - amount)
            return true
        else
            self.errors.add(:amount, 'Does not have enough fund; Avaliable fund: #{self.balance}')
            self.errors.any?
        end
    end
        
    def list_portfolios
        self.portfolios.where(account_id: self.id)
    end
    
    private
    def is_amount_valid(amount)
        if amount.is_a? Numeric
            self.errors.add(:amount, 'less than zero') if amount <= 0
            self.errors.any?
        else
            self.errors.add(:amount, 'Not a Number')
            self.errors.any?
        end
    end
end
