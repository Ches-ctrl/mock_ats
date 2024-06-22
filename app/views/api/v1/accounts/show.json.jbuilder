json.company do
  json.extract! @account, :id, :name
  json.jobs api_v1_company_jobs_url(@account)
end
