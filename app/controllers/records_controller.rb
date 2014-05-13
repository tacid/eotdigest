class RecordsController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [:new]

  def index
    records = Record.
      search(params[:search], :id, :content, :source, :date).
      order_by(parse_sort_param(:date, :source, :content))

    records = records.where(poster_id: current_user.id) unless (current_user.administrator? or current_user.editor?)
    records = records.order_by(:category_id) if params[:nogrouping].blank?
    records = records.order_by(:created_at, "DESC")

    # FILTERS
    records = records.category_id_is(params[:category]) unless params[:category].blank?

    if params[:report].blank? then
      records = records.where(approved: params[:approved] == '1') unless params[:approved].blank?
    else
      records = records.where(approved: true)
    end

    if params[:enddate].blank? and (!params[:startdate].blank? or !params[:report].blank?) then
      params[:enddate]   = Date.today.to_s end

    if params[:startdate].blank? and (!params[:enddate].blank? or !params[:report].blank?) then
      params[:startdate] = Record.order_by(:date).first.date.to_date.to_s end

    if !params[:startdate].blank? and !params[:enddate].blank? then
      records = records.where(date: Date.parse(params[:startdate])..Date.parse(params[:enddate]))
    end

    records = records.paginate(:page => params[:page]) unless params[:report].blank?

    hobo_index records
  end

  def show
    redirect_to root_path
  end
end
