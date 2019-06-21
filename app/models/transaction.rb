class Transaction < ActiveRecord::Base
    belongs_to :user
    belongs_to :stock

    accepts_nested_attributes_for :stock
end