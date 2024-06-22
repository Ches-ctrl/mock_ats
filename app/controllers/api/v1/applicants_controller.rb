class Api::V1::ApplicantsController < Api::V1::ApiController
  def create
    @job = Job.find(params[:job_id])
    @applicant = @job.applicants.build(applicant_params)
    unless @applicant.save
      render json: { error: @applicant.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  private

  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone, :stage, :status, :job_id, :resume)
  end
end
