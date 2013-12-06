require 'set'

class VideosController < ApplicationController
  before_filter :require_user#, :except => [:assign_translate_to_someone_else, :assign_translator]
  before_filter :admin_user, :only => [:assign_translate_to_someone_else, 
    :assign_type_to_someone_else, :assign_qa_to_someone_else, :create, :new ]

  def update
    @video = Video.find(params[:video_id])
    if @video.update_attributes(params[:video_id])
      flash[:success] = "Successfully updated video."
      redirect_to @video
    end
  end

def video_setup
    @user = User.find_by_id(params[:id])
    
    @trans_vids = Video.find_user_trans(params[:id])
    @digi_vids  = Video.find_user_digi(params[:id])
    @qa_vids = Video.find_user_qa(params[:id])

    @trans_vids_num = @trans_vids.length
    @digi_vids_num  = @digi_vids.length
    @qa_vids_num = @qa_vids.length

    @avail_trans = Video.find_avail_trans(params[:id])
    @avail_digi = Video.find_avail_digi(params[:id])
    @avail_qa = Video.find_avail_qa(params[:id])
    @avail_vids_num = @avail_trans.length + @avail_digi.length + @avail_qa.length

    @comp_trans = Video.find_comp_trans(params[:id])
    @comp_digi = Video.find_comp_digi(params[:id])
    @comp_qa = Video.find_comp_qa(params[:id])
    @comp_vids_num = @comp_trans.length + @comp_digi.length + @comp_qa.length

  end



  def available
  video_setup()
  Rails.cache.write("avail", @avail_vids_num)
  Rails.cache.write("trans", @trans_vids_num)
  Rails.cache.write("digi", @digi_vids_num)
  Rails.cache.write("qa", @qa_vids_num)
  Rails.cache.write("comp", @comp_vids_num)
  end


  def translate
    @user = current_user
    @trans_vids = Video.find_user_trans(params[:id])
    @trans_vids_num = @trans_vids.length

    cache("trans")
  end


  def digitize
    @user = current_user
    @digi_vids = Video.find_user_digi(params[:id])
    @digi_vids_num = @digi_vids.length

    cache("digi")
  end

  def qa
    @user = current_user
    @qa_vids = Video.find_user_qa(params[:id])
    @qa_vids_num = @qa_vids.length

    cache("qa")
  end

  def completed
    @user = current_user
    @comp_trans = Video.find_comp_trans(params[:id])
    @comp_digi = Video.find_comp_digi(params[:id])
    @comp_qa = Video.find_comp_qa(params[:id])
    @comp_vids_num = @comp_trans.length + @comp_digi.length + @comp_qa.length

    cache("comp")
  end

  def cache(cache_write)
    Rails.cache.write(cache_write, instance_variable_get('@'+cache_write+'_vids_num'))
    @avail_vids_num = Rails.cache.fetch("avail")
    @trans_vids_num = Rails.cache.fetch("trans")
    @digi_vids_num = Rails.cache.fetch("digi")
    @qa_vids_num = Rails.cache.fetch("qa")
    @comp_vids_num = Rails.cache.fetch("comp")
  end

  #TODO: add notices to inform user of successful assign/unassign/complete
  def assign_translator
    assign_translator_by_ids(params[:video_id], params[:id])
    redirect_to show_dashboard_path(current_user)
  end

  def assign_translator_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :translator_id => user_id,
      :due_date => 1.month.from_now
    )
  end

  def unassign_translator
    unassign_translater_by_ids(params[:video_id], params[:user_id])
    flash[:success] = "You have been successfully unassigned"
    redirect_to translate_path(current_user)
  end

  def unassign_translater_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :translator_id => nil
    )
  end

  def assign_typer
    assign_typer_by_ids(params[:video_id], params[:id])    
    redirect_to show_dashboard_path(current_user)
  end

  def assign_typer_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :typer_id => user_id,
      :due_date => 1.month.from_now  
      )
  end

  def unassign_typer
    unassign_typer_by_ids(params[:video_id], params[:id])
    flash[:success] = "You have been successfully unassigned"
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
      :due_date => 1.month.from_now
    )
  end

  def unassign_qa
    unassign_qa_by_ids(params[:video_id], params[:id])
    flash[:success] = "You have been successfully unassigned"
    redirect_to qa_path(params[:id])
  end

  def unassign_qa_by_ids(video_id, user_id)
    v = Video.find_by_video_id video_id
    v.update_attributes!(
      :qa_id => nil
    )
  end

  def admin_unassign_overdue_videos
    unassign_overdue_videos
    redirect_to users_index_path
  end

  def unassign_overdue_videos
    @all_overdue_trans_vids = Video.where('translator_id IS NOT NULL and translate_complete = ? and due_date < ?', false, Date.today)
    @all_overdue_digi_vids  = Video.where('typer_id IS NOT NULL AND translator_id IS NOT NULL AND translate_complete = ? and type_complete = ? and due_date < ?', true, false, Date.today)
    @all_overdue_qa_vids = Video.where('qa_id IS NOT NULL AND typer_id IS NOT NULL AND type_complete = ? AND qa_complete = ? and due_date < ?', true, false, Date.today)
    @all_overdue_trans_vids.each do |video|
      unassign_translater_by_ids(video.video_id, video.translator_id)
    end
    @all_overdue_digi_vids.each do |video|
      unassign_typer_by_ids(video.video_id, video.typer_id)
    end
    @all_overdue_qa_vids.each do |video|
      unassign_qa_by_ids(video.video_id, video.qa_id)
    end
  end

  def admin_send_deadline_approaching_reminders
    send_deadline_approaching_reminders
    redirect_to users_index_path
  end

  def send_deadline_approaching_reminders
    @all_deadline_approaching_trans_vids = Video.where('translator_id IS NOT NULL and translate_complete = ? and due_date > ? and due_date < ?', false, Date.today, 1.week.from_now)
    @all_deadline_approaching_digi_vids  = Video.where('typer_id IS NOT NULL AND translator_id IS NOT NULL AND translate_complete = ? and type_complete = ? and due_date > ? and due_date < ?', true, false, Date.today, 1.week.from_now)
    @all_deadline_approaching_qa_vids = Video.where('qa_id IS NOT NULL AND typer_id IS NOT NULL AND type_complete = ? AND qa_complete = ? and due_date > ? and due_date < ?', true, false, Date.today, 1.week.from_now)
    @users_to_email = []
    @all_deadline_approaching_trans_vids.each do |video|
      @users_to_email << video.translator_id
    end
    @all_deadline_approaching_digi_vids.each do |video|
      @users_to_email << video.typer_id
    end
    @all_deadline_approaching_qa_vids.each do |video|
      @users_to_email << video.qa_id
    end
    @users_to_email.to_set.each do |user_id|
      Reminder.deadline_approaching(User.find_by_id(user_id)).deliver
    end
  end
  
  def set_cache_complete
    comp_vids_num = Rails.cache.fetch("comp")
    Rails.cache.write("comp",comp_vids_num +1)
  end

  def set_handwritten_translate_complete
    v = Video.find_by_video_id params[:video_id]
    set_cache_complete()
    v.update_attributes!(:translate_complete => true)
    redirect_to translate_path(params[:id])
  end

  def set_digital_translate_complete
    v = Video.find_by_video_id(params[:video_id])
    set_cache_complete()
    flash[:success]= "#{v.title} is now ready to be QAed."
    v.update_attributes!(:translate_complete => true, :type_complete => true, :typer_id => params[:id])
    redirect_to translate_path(params[:id])
  end

 def set_type_complete
    v = Video.find_by_video_id params[:video_id]
    set_cache_complete()
    flash[:success]= "#{v.title} is now ready to be QAed."
    v.update_attributes!(:type_complete => true)
    redirect_to digitize_path(params[:id])
  end

  def set_qa_complete
    v = Video.find_by_video_id params[:video_id]
    set_cache_complete()
    flash[:success]= "#{v.title} is now completed."
    v.update_attributes!(:qa_complete => true)
    redirect_to qa_path(params[:id])
  end

  def video_details(video_id)
      @video = Video.find_by_video_id(video_id)
      
      @avail_vids_num = Rails.cache.fetch("avail")
      @trans_vids_num = Rails.cache.fetch("trans")
      @digi_vids_num = Rails.cache.fetch("digi")
      @qa_vids_num = Rails.cache.fetch("qa")
      @comp_vids_num = Rails.cache.fetch("comp")
  end

  def qa_video
      @user = current_user
      video_details(params[:video_id])
  end

  def upload_translation_handwritten
      @video = Video.find_by_video_id(params[:video_id])
      flash[:success] = "Your translation has been successfully uploaded"
      translate_video_handwritten
      redirect_to translate_video_handwritten_path
  end

  def translate_video
      @user = current_user
      video_details(params[:video_id])
  end

  def translate_video_handwritten
      @user = current_user
      video_details(params[:video_id])
  end

  def digitize_video
      @user = current_user
      video_details(params[:video_id])
  end

  def assign_translate_to_someone_else
    @users = User.order('email ASC')
    @video = Video.find_by_video_id(params[:video_id])
  end

  def assign_type_to_someone_else
    @users = User.order('email ASC')
    @video = Video.find_by_video_id(params[:video_id])
  end

  def assign_qa_to_someone_else
    @users = User.order('email ASC')
    @video = Video.find_by_video_id(params[:video_id])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    @video.set_initial_values
    if @video.save
      flash[:success] = "Video added successfully!"
      redirect_to videos_index_path
    else
      render 'new'
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      flash[:success] = "Video updated successfully"
      redirect_to videos_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    flash[:success] = "Video deleted successfully."
    redirect_to videos_index_path
  end

  def videos_index
    @videos = Video.order('subject ASC').order('course ASC').paginate(:per_page => 20, :page => params[:page])
  end

  ################################## Private Methods ################################
  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
