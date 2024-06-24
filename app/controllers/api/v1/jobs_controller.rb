include Pagy::Backend
class Api::V1::JobsController < Api::V1::ApiController
  before_action :assign_company

  def index
    if @company
      @jobs = @company.jobs
    else
      @pagy, @jobs = pagy(Job.all, items: 10, page_param: :number)
      @links_hash = pagy_jsonapi_links(@pagy)
    end
  end

  def show
    @job = @company.jobs.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    @job.account = @company
    if @job.save
      render json: @job
    else
      render json: { error: @job.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  private

  def assign_company
    @company = Account.find(params[:company_id]) if params[:company_id]
  end

  def job_params
    params.require(:job).permit(:title, :status, :job_type, :location, :account_id, :description)
  end
end
