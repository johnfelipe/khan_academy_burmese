namespace :redistribute do
  desc "TODO"
  task :unassign_overdue_videos => :environment do
    o = VideosController.new
    o.unassign_overdue_videos
  end

end
