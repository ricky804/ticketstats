class TransactionsController < ApplicationController
  def index
    activity = Transaction.new
    @activities = activity.activities(session[:rtuser_id])
    @comment = activity.monthly_activities(session[:rtuser_id], "Comment")
    @respond = activity.monthly_activities(session[:rtuser_id], "Correspond")
    @combined_chart = combined_chart(@comment, "Comment", @respond, "Correspond", "Activities for past 1 year")
  end
end
