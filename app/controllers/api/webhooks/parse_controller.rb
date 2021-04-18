class Api::Webhooks::ParseController < ApplicationController
  def create
    return if @run.parsed_at.present?
    @run.parse_into_db
    render :ok
  end

  private

  def set_run
    @run = Run.find_by(s3_filename: params[:s3_filename])
  rescue ActiveRecord::RecordNotFound
    render :not_found
  end
end
