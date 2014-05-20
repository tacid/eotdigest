class RecordsController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [:new]

  def index
    # DEFAULTS
    params[:onlyme] = '1'   if current_user.poster? and ((params[:onlyme].nil? and session[:onlyme].nil?) or params[:clear] == '1')
    params[:grouping] = '1' if (params[:grouping].nil? and session[:grouping].nil?) or params[:clear] == '1'

    # SESSION store for filter params
    %w(onlyme grouping category startdate enddate approved).each do |key|
      if not params[key].nil?;      session[key] = params[key]
      elsif not session[key].nil?;  params[key] = session[key]
      end
      params.delete(key) if params[key].blank?
    end

    records = Record.
      search(params[:search], :id, :content, :source, :date).
      order_by(parse_sort_param(:date, :source, :content))

    records = records.where(poster_id: current_user.id) if current_user.viewer? or !params[:onlyme].blank?
    records = records.order_by(:category_id) unless params[:grouping].blank? and params[:report].blank?
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
      records = records.where(date: Date.parse(params[:startdate])..(Date.parse(params[:enddate])+1.day))
    end

    records = records.paginate(:page => params[:page], per_page: (params[:report].blank? ? 30 : 10000))

    hobo_index records
  end

  def show
    redirect_to root_path
  end
end
