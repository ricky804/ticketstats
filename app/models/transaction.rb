class Transaction < ActiveRecord::Base
  has_many :attachments, foreign_key: "TransactionId"
  belongs_to :rtticket, foreign_key: "ObjectId"

  self.table_name = "transactions"
  establish_connection('rtdatabase')

  def valuable_actions
    # ["CommentEmailRecord", "Comment", "EmailRecord", "Correspond"]
    ["Comment", "Correspond"]
  end

  def activities(user_id)
    Transaction.where(
      creator: user_id,
      type: valuable_actions
    ).order('created desc').limit(10)
  end

  def monthly_activities(user_id, action = valuable_actions )
    Transaction.where(
      creator: user_id,
      type: action,
      created: (Time.now.midnight - 1.year)..Time.new.midnight
    ).group("DATE_FORMAT(created, '%Y-%m')").count

  end

end
