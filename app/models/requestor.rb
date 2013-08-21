class Requestor < ActiveRecord::Base
  belongs_to :customer
  has_many :rttickets, primary_key: "rtuser_id", foreign_key: "Creator"
  attr_accessible :email, :customer_id
  validates :email, presence: true, uniqueness: true, format: {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, :message => "Invalid email format"}

  def self.get_rtuser_id(emailaddr)
    rt_user = Rtuser.where(EmailAddress: emailaddr).first
    if not rt_user.blank?
      rt_user.id
    else
      return 0
    end
  end
  #This will generates an error when..new customer gets saved.
  #validates :customer_id, presence: true

end
