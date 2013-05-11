class IndexController < ApplicationController
  #See if user is not signed in
  before_filter :authenticate_user!

  def main
  end
end
