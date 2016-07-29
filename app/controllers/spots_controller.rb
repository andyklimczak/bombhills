class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy]

  # GET /spots
  # GET /spots.json
  def index
    @spots = Spot.all
    @current_user_spots = @spots.where(user: current_user)
    gon.search = Geocoder.search(params[:search]).first if params[:search].present?
    gon.spot = Spot.find(params[:id]) if params[:id].present? and Spot.exists?(params[:id])
    gon.user_signed_in = user_signed_in?
    gon.user_id = current_user.id
  end

  # GET /spots/1
  # GET /spots/1.json
  def show
  end

  # GET /spots/new
  def new
    @spot = Spot.new
  end

  # GET /spots/1/edit
  def edit
  end

  # POST /spots
  # POST /spots.json
  def create
    @spot = current_user.spots.new(spot_params)

    respond_to do |format|
      if @spot.save
        format.html { redirect_to spots_path(id: @spot.id), notice: 'Spot was successfully created.' }
        format.json { render :show, status: :created, location: @spot }
      else
        format.html { redirect_to :spots, notice: 'Location could not be created.' }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spots/1
  # PATCH/PUT /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to spots_path(id: @spot.id), notice: 'Spot was successfully created.' }
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render :edit }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1
  # DELETE /spots/1.json
  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to show_user_path(current_user.username), notice: 'Spot was successfully destroyed' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spot_params
      params.require(:spot).permit(:latitude, :longitude, :description, :title, :difficulty, :user_id, :post_id)
    end
end
