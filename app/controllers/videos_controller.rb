class VideosController < ApplicationController
  before_filter :require_user
  def video_setup
    @user = User.find_by_id(params[:id])

    find_avail(@user)

    @trans_vids = Video.where(:translate_complete => false, :translator_id => @user.id)
    @digi_vids  = Video.where(:type_complete => false, :typer_id => @user.id)
    @qa_vids = Video.where(:qa_complete => false, :qa_id => @user.id)

    find_comp(@user)
  end

  def find_avail(user)
    @avail_trans = Video.where(:translator_id => nil, :translate_complete => false)
    @avail_digi = Video.where('typer_id IS NULL AND translator_id IS NOT NULL AND translate_complete = ? and type_complete = ? AND translator_id != ?', true, false, user.id)
    @avail_qa = Video.where('qa_id IS NULL AND typer_id IS NOT NULL AND type_complete = ? AND qa_complete = ? AND translator_id != ? AND typer_id != ?', true, false, user.id, user.id)
    @avail = @avail_trans + @avail_digi + @avail_qa
  end

  def find_comp(user)
    @comp_trans = Video.where(:translate_complete => true, :translator_id => user.id)
    @comp_digi = Video.where('type_complete = ? AND typer_id = ? AND translator_id != ?', true, user.id, user.id)
    @comp_qa = Video.where(:qa_complete => true, :qa_id => user.id)
    @comp = @comp_trans + @comp_digi + @comp_qa
  end

  def info
    Logger.info("CRON JOB RUNNING")
  end

  def available
    video_setup()
  end

  def translate
    video_setup()
  end

  def digitize
    video_setup()
  end

  def qa
    video_setup()
  end

  def completed
    video_setup()
  end

  #TODO: add notices to inform user of seccessful assign/unassign/complete
  def assign_translator
    assign_translator_by_ids(params[:video_id], params[:id])
    redirect_to show_dashboard_path(params[:id])
  end

  def assign_translator_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :translator_id => user_id,
      :due_date => 1.month.from_now.strftime('%b %d %Y')
    )
  end

  def unassign_translator
    unassign_translater_by_ids(video_id, user_id)
    redirect_to translate_path(params[:id])
  end

  def unassign_translater_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :translator_id => nil
    )
  end

  def assign_typer
    assign_typer_by_ids(params[:video_id], params[:id])    
    redirect_to show_dashboard_path(params[:id])
  end

  def assign_typer_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :typer_id => user_id,
      :due_date => 1.month.from_now.strftime('%b %d %Y')       
      )
  end

  def unassign_typer
    unassign_typer_by_ids(params[:video_id], params[:id])
    redirect_to digitize_path(params[:id])
  end

  def unassign_typer_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :typer_id => nil
    )
  end

  def assign_qa
    assign_qa_by_ids(params[:video_id], params[:id])
    redirect_to show_dashboard_path(params[:id])
  end

  def assign_qa_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :qa_id => user_id,
      :due_date => 1.month.from_now.strftime('%b %d %Y')
    )
  end

  def unassign_qa
    unassign_qa_by_ids(params[:video_id], params[:id])
    redirect_to qa_path(params[:id])
  end

  def unassign_qa_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :qa_id => nil
    )
  end

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

  def set_translate_complete
    # v = Video.find_by_video_id params[:video_id]
    # v.update_attributes!(
    #   :translate_complete => true
    # )
    # redirect_to translate_path(params[:id])
  end

  def set_type_complete
    # v = Video.find_by_video_id params[:video_id]
    # v.update_attributes!(
    #   :type_complete => true
    # )
    # redirect_to digitize_path(params[:id])
  end

  def set_qa_complete
    # v = Video.find_by_video_id params[:video_id]
    # v.update_attributes!(
    #   :qa_complete => true
    # )
    # redirect_to qa_path(params[:id])
  end

end
