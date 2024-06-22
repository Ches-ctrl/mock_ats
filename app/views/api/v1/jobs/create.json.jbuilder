json.job do
  json.partial! 'api/v1/jobs/info', job: @job
end
