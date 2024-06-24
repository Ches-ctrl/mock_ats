json.jobs @jobs.each do |job|
  json.partial! 'api/v1/jobs/info', job: job
end

if @links_hash.present?
  json.pagination do
    json.extract! @links_hash, :first, :last, :prev, :next
  end
end