class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  def get_untouched_links
    link_count = params["count"] || 10

    results = Link.where(:progress => nil or :progress => "").limit(link_count.to_i)

    render :json => results

    results.update_all(:progress => "distributed")
  end



  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    # Custom

    # Setting youtube_link
    full_link = link_params["full_link"].to_s
    full_link_parameters_hash = Rack::Utils.parse_nested_query(full_link[full_link.index("?") + 1, full_link.length])
    @link.youtube_link = full_link_parameters_hash["v"]

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:full_link, :youtube_link, :progress, :seen_count, :video_id, :transcript_id)
    end
end
