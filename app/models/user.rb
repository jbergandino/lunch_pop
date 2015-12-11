class User < ActiveRecord::Base
  has_many :cust_cards
  has_many :orders
  has_many :products, through: :orders


  #validates :email, presence: true
  validates :email, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :email, :uniqueness => {message: "Already Exists In Our System, Please Log In!"}

  validates :username, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :username, :uniqueness => {message: "Already Exists, Please Try Another"}

  validates :fname, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :lname, :presence => {message: "Field is Empty, Please Complete All Fields!"}

  validates :password, :presence => {message: "Field is Empty, Please Complete All Fields!"}
  validates :password, :confirmation => {message: "Password's Do Not Match, Please Try Again"}
  validates :password, length: { minimum: 6, too_short: "Must Be At Least 6 Characters" }
end
