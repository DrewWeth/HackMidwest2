class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def post_update_progress
    youtube_link = params["youtube"]
    progress = params["progress"]

    if youtube_link and progress
      if result = Link.where(:youtube_link =>youtube_link).take
        result.progress = progress
        result.save
        render :json => result
      else
        render :json => result
      end
    else
      render :json => "FAILED. Missing youtube or progress. " + params.to_s
    end
  end

  def post_elastic_id
    url = params["link"]
    e_id = params["id"]
    if video
      if e_id
        link = Link.where(:full_link => url).take
        link.video = e_id
        link.save
        render :json => link
      else
        render :json => "No e_id"
      end
    else
      render :json => "No link"
    end
  end

  def create
    @link = Link.new
    # Custom
    @link.full_link = params["full_link"]
    # Setting youtube_link
    full_link = params["full_link"].to_s
    if !full_link.blank?
      full_link_parameters_hash = Rack::Utils.parse_nested_query(full_link[full_link.index("?") + 1, full_link.length])
      @link.youtube_link = full_link_parameters_hash["v"]

      if @link.save
        render :json => @link
      else
        Link.where(:full_link => full_link).take.increment!(:seen_count)
        render :json => "FAILED. No full_link or link not unique"
      end
    else
      render :json => "No link"
    end
  end

  def channel_create
    args = {}
    args["url"] = params["url"]
    channel = Channel.new(args)

    if args["url"]
      if channel.save
        render :json => channel
      else
        render :json => "Could not save. Duplicate data?"
      end
    else
      render :json => "url not provided"
    end
  end

  def channel_update
    args = {}
    args["url"] = params["url"]
    args["progress"] = params["progress"]

    if args["url"] and args["progress"]
      if channel = Channel.where(:url => args["url"]).take
        channel.progress = args["progress"]
        if channel.save
          render :json => channel
        else
          render :json => "Error saving."
        end
      else
        render :json => "Channel not found"
      end
    else
      render :json => "url and progress not provided"
    end
  end

  def create_video
    request_body = JSON.parse(request.body.read)
    puts request_body
    new_video = Video.create(:transcript => request_body["transcript"], :compressed_text => request_body["transcript"].gsub(/([0-9]?[0-9]):[0-9][0-9] +/, ""), :thumbnail => request_body["details"]["thumbnail"], :views => request_body["details"]["views"].to_i, :video_link => request_body["details"]["link"], :title => request_body["details"]["title"])
    render :json => new_video
  end

end
