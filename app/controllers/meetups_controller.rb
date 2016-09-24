# frozen_string_literal: true
class MeetupsController < ApplicationController
  before_action :set_meetup, only: [:show, :edit, :update, :destroy]
  before_action :set_spot
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_permission, except: [:show, :index, :new, :create]

  # GET /meetups
  # GET /meetups.json
  def index
    @meetups = @spot.meetups
  end

  # GET /meetups/1
  # GET /meetups/1.json
  def show
  end

  # GET /meetups/new
  def new
    @meetup = Meetup.new(spot: @spot)
  end

  # GET /meetups/1/edit
  def edit
  end

  # POST /meetups
  # POST /meetups.json
  def create
    @meetup = Meetup.new(meetup_params)

    respond_to do |format|
      if @meetup.save
        format.html { redirect_to spot_meetup_path(@spot, @meetup), notice: 'Meetup was successfully created.' }
        format.json { render :show, status: :created, meetup: @meetup }
      else
        format.html { render :new }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetups/1
  # PATCH/PUT /meetups/1.json
  def update
    respond_to do |format|
      if @meetup.update(meetup_params)
        format.html { redirect_to spot_meetup_path(@spot, @meetup), notice: 'Meetup was successfully updated.' }
        format.json { render :show, status: :ok, meetup: @meetup }
      else
        format.html { render :edit }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetups/1
  # DELETE /meetups/1.json
  def destroy
    @meetup.destroy
    respond_to do |format|
      format.html { redirect_to meetups_url, notice: 'Meetup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meetup
    @meetup = Meetup.find(params[:id])
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meetup_params
    params.require(:meetup).permit(:title, :description, :time).merge(user_id: current_user.id, spot_id: @spot.id)
  end

  def require_permission
    super(@meetup)
  end
end
