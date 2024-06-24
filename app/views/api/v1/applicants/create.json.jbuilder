json.applicant do
  json.extract! @applicant, :first_name, :last_name, :email, :phone, :stage, :status
  json.job_url api_v1_job_applicants_url(@applicant.job)
end
