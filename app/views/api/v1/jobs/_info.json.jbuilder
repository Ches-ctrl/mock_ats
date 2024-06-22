json.extract! job, :id, :title, :status, :job_type, :location
json.absolute_url api_v1_company_job_url(job.account, job)
json.company job.account.name
json.company_url api_v1_company_url(job.account)
json.application_url api_v1_job_applicants_url(job)