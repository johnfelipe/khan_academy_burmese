namespace :redistribute do
  desc "TODO"
  task :unassign_overdue_videos => :environment do
  	videos_controller.unassign_overdue_videos()
  end

end
