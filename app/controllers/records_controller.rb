class RecordsController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [:new]

  def index
    records = Record.
      search(params[:search], :id, :content, :source, :date).
      order_by(parse_sort_param(:date, :source, :content))

    records = records.order_by(:category_id) if params[:nogrouping].blank?
    records = records.order_by(:created_at, "DESC")

    # FILTERS
    records = records.category_id_is(params[:category]) unless params[:category].blank?

    records = records.where(approved: params[:approved] == '1') unless params[:approved].blank?

    params[:enddate]   = Date.today.to_s                if params[:enddate].  blank? and !params[:startdate].blank?
    params[:startdate] = Record.order_by(:date).first.date.to_s  if params[:startdate].blank? and !params[:enddate].  blank?
    if !params[:startdate].blank? and !params[:enddate].blank? then
      records = records.where(date: Date.parse(params[:startdate])..Date.parse(params[:enddate]))
    end

    records = records.paginate(:page => params[:page])

    hobo_index records
  end

  def show
    redirect_to root_path
  end
end
