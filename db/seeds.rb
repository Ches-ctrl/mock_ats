job_titles = ["Electrical Engineer", "Assistant Engineer", "Chemical Engineer", "Chief Engineer", "Drafter", "Engineering Technician", "Geological Engineer", "Biological Engineer", "Maintenance Engineer", "Mining Engineer", "Nuclear Engineer", "Petroleum Engineer", "Plant Engineer", "Production Engineer", "Quality Engineer", "Safety Engineer", "Sales Engineer", "Chief People Officer", "VP of Miscellaneous Stuff", "Chief Robot Whisperer", "Director of First Impressions", "Culture Operations Manager", "Director of Ethical Hacking", "Software Ninjaneer", "Director of Bean Counting", "Digital Overlord", "Director of Storytelling", "Researcher", "Research Assistant", "Data Analyst", "Business Analyst", "Financial Analyst", "Biostatistician", "Title Researcher", "Market Researcher", "Title Analyst", "Medical Researcher", "Mentor", "Tutor/Online Tutor", "Teacher", "Teaching Assistant", "Substitute Teacher", "Preschool Teacher", "Test Scorer", "Online ESL Instructor", "Professor", "Assistant Professor", "Graphic Designer", "Artist", "Interior Designer", "Video Editor", "Video or Film Producer", "Playwright", "Musician", "Novelist/Writer", "Computer Animator", "Photographer", "Camera Operator", "Sound Engineer", "Motion Picture Director", "Actor", "Music Producer", "Director of Photography", "Nurse", "Travel Nurse", "Nurse Practitioner", "Doctor", "Caregiver", "CNA", "Physical Therapist", "Pharmacist", "Pharmacy Assistant", "Medical Administrator", "Medical Laboratory Tech", "Physical Therapy Assistant", "Massage Therapy", "Dental Hygienist", "Orderly", "Personal Trainer", "Massage Therapy", "Medical Laboratory Tech", "Phlebotomist", "Medical Transcriptionist", "Telework Nurse/Doctor", "Reiki Practitioner"]
locations = ["Ahmadabad", "Amreli", "Bharuch", "Bhavnagar", "Bhuj", "Dwarka", "Gandhinagar", "Godhra", "Jamnagar", "Junagadh", "Kandla", "Khambhat", "Kheda", "Mahesana", "Morbi", "Nadiad", "Navsari", "Okha", "Palanpur", "Patan", "Porbandar", "Rajkot", "Surat", "Surendranagar", "Valsad"]
company_names = ["DataAxis Innovationszz", "DataHorizon Solutionszz", "DataGenius Hubzz", "ModernData Creationszz", "DataGraph Insightszz", "Data Driven Insightszz", "Infinite Data Innovationszz", "Cloud Data Architectszz", "Data Fusion Dynamicszz", "DataCurve Technologieszz", "InfoSync Labszz", "InfoHarbor Technologieszz", "ByteLogic Technologieszz", "InfoQuest Data Solutionszz", "InsightIQ Analytics"]
company_names.each do |name|
  account = Account.find_or_create_by(name: name)
  job_titles.sample(10).each do |job_title|
    job = account.jobs.find_or_initialize_by(
      title: job_title,
      status: Job.statuses.values.sample,
      job_type: Job.job_types.values.sample,
      location: locations.sample
    )
    job.save
  end
end

