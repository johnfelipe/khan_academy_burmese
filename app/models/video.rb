class Video < ActiveRecord::Base
  attr_accessible :course, :qa_complete, :qa_id, :subject, :title, 
  :translate_complete, :translator_id, :type_complete, :typer_id, :video_id

  validates :video_id, :presence => true, :uniqueness => true #add uniqueness in db too
end
