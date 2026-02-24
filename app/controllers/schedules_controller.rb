class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show]

  def index
    @schedules = Schedule.includes(:bus, :destination).order(departure: :asc)

    respond_to do |format|
      format.html
      format.json do
        if @schedules.present?
          render json: { schedules: @schedules }, status: :ok
        else
          render json: { message: "No schedules found." }, status: :ok
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      
      format.json do
        if @schedule.present?
          render json: { schedule: @schedule }, status: :ok
        else
          render json: { message: "No schedules found." }, status: :ok
        end
      end
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find_by(id: params[:id])
  end
end