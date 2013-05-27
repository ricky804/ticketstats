class Email < ActiveRecord::Base
  belongs_to :customer

  attr_accessible :email, :customer_id

  validates :email, presence: true, uniqueness: true, format: {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, :message => "Invalid email format"}

  #This will generates an error when..new customer gets saved.
  #validates :customer_id, presence: true

  #Define what ticket stauts we will consider as closed
  #def closed_ticket_status
  #  @lst_ticket_status = ["resolved", "deleted", "rejected"]
  #end
end
