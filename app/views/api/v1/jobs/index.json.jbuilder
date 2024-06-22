json.jobs @jobs.each do |job|
  json.partial! 'api/v1/jobs/info', job: job
end
