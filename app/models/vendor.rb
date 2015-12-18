class Vendor < ActiveRecord::Base
	 has_many :myproducts
	# has_many :payables

  validates :bname, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :bname, :uniqueness => {message: "Already Exists, Please Try Another"}

  validates :contact, :presence => {message: "Field is Empty, Please Complete All Fields!"}

  validates :address, :presence => {message: "Field is Empty, Please Complete All Fields!"}

  validates :city, :presence => {message: "Field is Empty, Please Complete All Fields!"}

  validates :zip, :presence => {message: "Field is Empty, Please Complete All Fields!"}

  validates :username, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :username, :uniqueness => {message: "Already Exists, Please Try Another"}

  validates :email, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :email, :uniqueness => {message: "Already Exists In Our System, Please Log In!"}

  validates :password, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :password, :confirmation => {message: "Password's Do Not Match, Please Try Again"}
  validates :password, length: { minimum: 6, too_short: "Must Be At Least 6 Characters" }

  validates :phone, :presence => {message: "Field is Empty, Please Complete All Fields!"}

end
