class ExploreController < ApplicationController

  def index
    hash = {}
    hash["videos"] = Video.count
    hash["links"] = Link.count
    hash["channel"] = Channel.count
    hash["parsed_links"] = Link.where(:progress => "distributed").count
    @data = hash.to_json

  end

  def search
    render :json => Video.where("compressed_text LIKE ? ", "%#{params["s"]}%")

  end

  def stats
    hash = {}
    hash["videos"] = Video.count
    hash["links"] = Link.count
    hash["channel"] = Channel.count
    hash["parsed_links"] = Link.where(:progress => "distributed").count
    render :json => hash
  end
end
