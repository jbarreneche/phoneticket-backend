namespace :reservations do
  task cleanup: :environment do
    service = CleanupReservationsService.new
    service.call
    puts "#{Time.now} cleaned up with time: #{service.now + 1.hour}"
  end
end
