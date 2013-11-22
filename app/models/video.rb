class Video < ActiveRecord::Base
  attr_accessible :course, :qa_complete, :qa_id, :subject, :title, 
  :translate_complete, :translator_id, :type_complete, :typer_id, :video_id, :due_date

  validates :video_id, :presence => true, :uniqueness => true #add uniqueness in db too

  def unassign_overdue_videos
    @all_assigned_trans_vids = Video.where('translator_id IS NOT NULL and translate_complete = ?', false)
    @all_assigned_digi_vids  = Video.where('typer_id IS NOT NULL AND translator_id IS NOT NULL AND translate_complete = ? and type_complete = ?', true, false)
    @all_assigned_qa_vids = Video.where('qa_id IS NOT NULL AND typer_id IS NOT NULL AND type_complete = ? AND qa_complete = ?', true, false)
    @all_assigned_trans_vids.each do |video|
      unassign_translater_by_ids(video.video_id, video.translator_id)
    end
    @all_assigned_digi_vids.each do |video|
      unassign_typer_by_ids(video.video_id, video.typer_id)
    end
    @all_assigned_qa_vids.each do |video|
      unassign_qa_by_ids(video.video_id, video.qa_id)
    end
    redirect_to translate_path(params[:id])
  end
  
end
