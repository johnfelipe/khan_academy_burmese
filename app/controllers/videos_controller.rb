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
    
    find_user_vids(params[:id])

    find_avail_vids(params[:id])

    find_comp_vids(params[:id])
 
    initialize_cached_nums()

  end

  def find_user_vids(user_id)
    @trans_vids = Video.find_user_trans(user_id)
    @trans_vids_num = @trans_vids.length

    @digi_vids  = Video.find_user_digi(user_id)
    @digi_vids_num  = @digi_vids.length

    @qa_vids = Video.find_user_qa(user_id)
    @qa_vids_num = @qa_vids.length
  end 

  def find_avail_vids(user_id)
    @avail_trans = Video.find_avail_trans()
    @avail_digi = Video.find_avail_digi(user_id)
    @avail_qa = Video.find_avail_qa(user_id)
    @avail_vids_num = @avail_trans.length + @avail_digi.length + @avail_qa.length
  end
 
  def find_comp_vids(user_id)
    @comp_trans = Video.find_comp_trans(user_id)
    @comp_digi = Video.find_comp_digi(user_id)
    @comp_qa = Video.find_comp_qa(user_id)
    @comp_vids_num = @comp_trans.length + @comp_digi.length + @comp_qa.length
  end

  def initialize_cached_nums
    $avail = @avail_vids_num
    $trans = @trans_vids_num
    $digi = @digi_vids_num
    $qa = @qa_vids_num
    $comp = @comp_vids_num
  end



  def available
  @user = current_user
  video_setup()
  end

  def set_cache_nums
    @avail_vids_num = $avail
    @trans_vids_num = $trans
    @digi_vids_num = $digi
    @qa_vids_num = $qa
    @comp_vids_num = $comp
  end

  def translate
    @user = current_user
    @trans_vids = Video.find_user_trans(params[:id])
    @trans_vids_num = @trans_vids.length
    $trans = @trans_vids_num
    set_cache_nums()
  end


  def digitize
    @user = current_user
    @digi_vids = Video.find_user_digi(params[:id])
    @digi_vids_num = @digi_vids.length
    $digi = @digi_vids_num
    set_cache_nums()

  end

  def qa
    @user = current_user
    @qa_vids = Video.find_user_qa(params[:id])
    @qa_vids_num = @qa_vids.length
    $qa = @qa_vids_num
    set_cache_nums()
  end

  def completed
    @user = current_user
    find_comp_vids(params[:id])
    @comp_vids_num = @comp_trans.length + @comp_digi.length + @comp_qa.length
    $comp = @comp_vids_num
    set_cache_nums()
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
    @user_to_email = trans_vids_emails + digi_vids_emails + qa_vids_email
    @users_to_email.to_set.each do |user_id|
      Reminder.deadline_approaching(User.find_by_id(user_id)).deliver
    end
  end

  def trans_vids_emails
    users_to_email = []
    trans_vids_deadline_approaching.each do |video|
      users_to_email << video.translator_id
     end
     users_to_email
  end

  def digi_vids_emails
    users_to_email = []
    digi_vids_deadline_approaching.each do |video|
      users_to_email << video.typer_id
    end
    users_to_email
  end

  def qa_vids_emails
    users_to_email = []
    qa_vids_deadline_approaching.each do |video|
      users_to_email << video.qa_id
    end
    users_to_email
  end

  


  def set_handwritten_translate_complete
    set_complete("translate")
    flash[:success] = "#{@vid.title} is now ready to be digitized"
    redirect_to translate_path(params[:id])
  end

  def set_digital_translate_complete
    set_complete("translate")
    flash[:success]= "#{@vid.title} is now ready to be QAed."
    @vid.update_attributes!(:type_complete => true, :typer_id => params[:id])
    redirect_to translate_path(params[:id])
  end

 def set_type_complete
    set_complete("type")
    flash[:success]= "#{@vid.title} is now ready to be QAed."
    redirect_to digitize_path(params[:id])
  end

  def set_qa_complete
    set_complete("qa")
    flash[:success]= "#{@vid.title} is now completed."
    redirect_to qa_path(params[:id])
  end

  def set_complete(type)
   @vid = Video.find_by_video_id(params[:video_id])
   set_cache_complete()
   sym = (type+"_complete").to_sym
   @vid.update_attributes!(sym => true)
  end

  def video_details(video_id)
      @video = Video.find_by_video_id(video_id)
      set_cache_nums()
  end

  def set_cache_complete
    $comp += 1
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

  def qa_video
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

  def handwritten_index
    @videos = Video.get_unfinished_handwritten.order('subject ASC').order('course ASC').paginate(:per_page => 20, :page => params[:page])
    @my_handwritten = Video.get_unfinished_handwritten_assigned_to_me(current_user)
  end

  def download
    name = Video.find(params[:id]).translation_handwritten
    send_file "#{Rails.public_path}/assets/#{name.url}"
  end
  
  def download_zip
    require 'zip'
    zipfile_name = "#{Rails.public_path}/tmp/translations.zip"
    directory = "#{Rails.public_path}/assets/" # TODO NEED TO CHANGE TO DIR WHERE TRANSLATIONS ARE STORED
    to_zip = Array.new
    my_handwritten = Video.get_unfinished_handwritten_assigned_to_me(current_user)
    
    #get all filenames
    my_handwritten.each { |video| to_zip << "#{video.translation_handwritten.url}" }

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      to_zip.each do |filename|
        zipfile.add filename, directory + filename
      end
    end
    send_file zipfile_name, :type => 'application/zip', :x_sendfile => true
  end


  ################################## Private Methods ################################
  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
