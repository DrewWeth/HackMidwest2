class ExploreController < ApplicationController

  def index
  end

  def search
    render :json => Video.where("compressed_text LIKE ? ", "%#{params["s"]}%")
  end
end
