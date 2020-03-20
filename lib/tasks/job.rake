namespace :job do
  desc "TODO"
  task capture: :environment do
    PacketCaptureJob.perform_later
  end
  task lcapture: :environment do
    while true
      PacketCaptureJob.perform_now
      sleep(1)
    end
  end
end
