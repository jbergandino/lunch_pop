class Product < ActiveRecord::Base
	belongs_to :order
	belongs_to :payable
	belongs_to :vendor
	belongs_to :user
	
end
