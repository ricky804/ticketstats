class RtqueuesController < ApplicationController
  def index
    @rtqueues = Rtqueue.all
  end

  def show
  end

  def new
  end

end
