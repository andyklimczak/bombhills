# frozen_string_literal: true
class MeetupAttendeesController < ApplicationController
  before_action :set_meetup, only: [:create, :destroy]
  before_action :set_user, only: [:create, :destroy]
  before_action :set_meetup_attendee, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :require_permission, only: [:destroy]

  # POST /meetup_attendee
  # POST /meetup_attendee.json
  def create
    @meetup_attendee = MeetupAttendee.new(meetup_attendee_params)
    @meetup_attendee.save
    render json: @meetup_attendee
  end

  # DELETE /meetup_attendee
  # DELETE /meetups_attendee
  def destroy
    @meetup_attendee.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meetup
    @meetup = Meetup.find(params[:meetup_attendee][:meetup_id])
  end

  def set_user
    @user = current_user
  end

  def set_meetup_attendee
    @meetup_attendee = MeetupAttendee.find_by(user: @user, meetup: @meetup)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meetup_attendee_params
    params.require(:meetup_attendee).permit(:meetup_id).merge(user_id: @user.id)
  end

  def require_permission
    super(@meetup_attendee)
  end
end
