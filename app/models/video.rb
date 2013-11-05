class Video < ActiveRecord::Base
  attr_accessible :course, :qa_complete, :qa_id, :subject, :title, 
  :translate_complete, :translator_id, :type_complete, :typer_id, :video_id

  validates :video_id, :presence => true, :uniqueness => true #add uniqueness in db too

  def assign_translate(user_id)
  end

  def assign_type(user_id)
  end

  def assign_qa(user_id)
  end

  def set_complete()
  end

  
end
