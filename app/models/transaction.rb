class Transaction < ActiveRecord::Base
  VALUABLE_ACTIONS = ["Comment", "Correspond"]

  has_many :attachments, foreign_key: "TransactionId"
  belongs_to :rtticket, foreign_key: "ObjectId"

  self.table_name = "transactions"
  establish_connection('rtdatabase')

  def self.activities(user_id)
    scoped.where(
      creator: user_id,
      type: VALUABLE_ACTIONS
    ).order('created desc').limit(10)
  end

  def self.monthly_activities(user_id, action)
    scoped.where(
      creator: user_id,
      type: action,
      created: (Time.now.midnight - 1.year)..Time.new.midnight
    ).group("DATE_FORMAT(created, '%Y-%m')").count
  end
end
