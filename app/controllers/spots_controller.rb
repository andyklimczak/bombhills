# frozen_string_literal: true
class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_permission, except: [:show, :index, :create, :new]

  # GET /spots
  # GET /spots.json
  def index
    @spots = Spot.all
    gon.search = search_param_spot
    gon.spot = id_param_spot
    gon.user_signed_in = user_signed_in?
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
    @spot = Spot.new(spot_params)

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
        format.html { redirect_to spots_path(id: @spot.id), notice: 'Spot was successfully updated.' }
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render spots_path(id: @spot.id) }
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
    params.require(:spot).permit(:latitude, :longitude, :description, :title, :difficulty, :post_id, :traffic).merge(user_id: current_user.id)
  end

  def search_param_spot
    Geocoder.search(params[:search]).first if params[:search].present?
  end

  def id_param_spot
    Spot.find(params[:id]) if params.key?(:id) && Spot.where(id: params[:id]).exists?
  end

  def require_permission
    super(@spot)
  end
end
