class Video < ActiveRecord::Base
  attr_accessible :course, :qa_complete, :qa_id, :subject, :title, 
  :translate_complete, :translator_id, :type_complete, :typer_id, :video_id, :due_date, :translation_handwritten

  validates :video_id, :presence => true, :uniqueness => true

  mount_uploader :translation_handwritten, TranslationsUploader

  before_create :set_due_date_to_month_from_now

  #prevent null due dates
  def set_due_date_to_month_from_now
  	self.due_date = 1.month.from_now
  end

  def set_initial_values
  	self.translate_complete = false
  	self.type_complete = false
  	self.qa_complete = false
  end

 def self.find_user_trans(user_id)
    Video.where(:translate_complete => false, :translator_id => user_id)
  end

  def self.find_user_digi(user_id)
    Video.where(:type_complete => false, :typer_id => user_id)
  end

  def self.find_user_qa(user_id)
    Video.where(:qa_complete => false, :qa_id => user_id)
  end


  def self.find_avail_trans(user_id)
  videos = Video.where(:translator_id => nil, :translate_complete => false)
  end

  def self.find_avail_digi(user_id)
  Video.where('typer_id IS NULL AND translator_id IS NOT NULL AND translate_complete = ? and type_complete = ? AND   translator_id != ?', true, false, user_id)
  end

  def self.find_avail_qa(user_id)
  Video.where('qa_id IS NULL AND typer_id IS NOT NULL AND type_complete = ? AND qa_complete = ? AND translator_id != ? AND typer_id != ?', true, false, user_id, user_id)
  end
 
  def self.find_comp_trans(user_id)
  Video.where(:translate_complete => true, :translator_id => user_id)
  end

  def self.find_comp_digi(user_id)
  Video.where('type_complete = ? AND typer_id = ? AND translator_id != ?', true, user_id, user_id)
  end

  def self.find_comp_qa(user_id)
  Video.where(:qa_complete => true, :qa_id => user_id)
  end
  
end
