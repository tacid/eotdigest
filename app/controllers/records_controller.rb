class RecordsController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [:new]

  def index
    # DEFAULTS
    params[:onlyme] = '1'   if current_user.poster? and ((params[:onlyme].nil? and session[:onlyme].nil?) or params[:clear] == '1')
    params[:grouping] = '1' if (params[:grouping].nil? and session[:grouping].nil?) or params[:clear] == '1'

    # SESSION store for filter params
    %w(onlyme grouping category startdate enddate approved page sort searchrecord).each do |key|
      if not params[key].nil?;      session[key] = params[key]
      elsif not session[key].nil?;  params[key] = session[key]
      end
      params.delete(key) if params[key].blank?
    end

    records = Record.includes(:poster,:category)
    records = records.order_by('hex(categories.treeorder)') unless params[:grouping].blank? and params[:report].blank?

    pp params[:searchrecord]
    records = records.search(params[:searchrecord], :id, :content, :source).
                      order_by(parse_sort_param(:date, :source, :content))

    records = records.where(poster_id: current_user.id) if current_user.viewer? or !params[:onlyme].blank?
    records = records.order_by(:date, "DESC") if params[:sort].blank?

    # FILTERS
    records = records.where(category_id: [params[:category].to_i]+Category.find(params[:category]).descendants.map(&:id)) unless params[:category].blank?

    if params[:report].blank? then
      records = records.where(approved: params[:approved] == '1') unless params[:approved].blank?
    else
      records = records.where(approved: true)
    end

    if params[:enddate].blank? and (!params[:startdate].blank? or !params[:report].blank?) then
      params[:enddate]   = I18n.l(Date.today) end

    if params[:startdate].blank? and (!params[:enddate].blank? or !params[:report].blank?) then
      params[:startdate] = I18n.l(Record.order_by(:date).first.date.to_date) end

    if !params[:startdate].blank? and !params[:enddate].blank? then
      records = records.where(date: DateTime.parse(params[:startdate])..DateTime.parse(params[:enddate]+' 23:59:59') )
    end

    params[:page] = 1 if params[:page].to_i > (records.count/30 + 1) or !params[:report].blank?
    records = records.paginate(:page => params[:page], per_page: (params[:report].blank? ? 30 : 10000))

    hobo_index records
  end

  def show
    redirect_to root_path
  end
end
