class Admin < ActiveRecord::Base
	has_many :users
	has_many :cust_cards
	has_many :vendors
end
