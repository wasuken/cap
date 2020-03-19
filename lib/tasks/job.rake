namespace :job do
  desc "TODO"
  task capture: :environment do
    PacketCaptureJob.perform_later
  end
end
