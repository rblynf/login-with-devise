class ScheduleTestJob < ApplicationJob
	queue_as :schedule_test_ly

  before_enqueue do |job|
    # Do something with the job instance
    p "before_enqueue "
    p job
  end

	def perform(*args)
		p "schedule_test job start run"
		(0..100000).each{|i| i}
		p "schedule_test job end run"
	end
end