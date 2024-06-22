class Api::V1::JobsController < Api::V1::ApiController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end
end
