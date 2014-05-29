class ReportsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [ :new ]

  def index
    reports = Report.search(params[:search], :name, :created_at, :content, :urlkey ).
                      order_by(parse_sort_param(:name,:created_at,:urlkey))
    hobo_index reports
  end
end
