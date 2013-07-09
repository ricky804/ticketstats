class TestsController < ApplicationController
  def index
  end

  def new
    respond_to do |format|
      format.html { redirect_to favorites_path }
      format.js
    end

  end

end
