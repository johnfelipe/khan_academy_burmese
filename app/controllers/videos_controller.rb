class VideosController < ApplicationController

def available
@user = User.find_by_id(params[:id])

avail_trans = Video.where(:translator_id => nil)
avail_digi = Video.where(:typer_id => nil)
avail_qa = Video.where(:qa_id => nil)
@avail = avail_trans + avail_digi + avail_qa

@trans_vids = Video.where(:translator_id => params[:id])
@digi_vids  = Video.where(:typer_id => params[:id])
@qa_vids = Video.where(:qa_id => params[:id])

comp_trans = Video.where(:translate_complete => true, :translator_id => params[:id])
comp_digi = Video.where(:type_complete => true, :typer_id => params[:id])
comp_qa = Video.where(:qa_complete => true, :qa_id => params[:id])
@comp = comp_trans + comp_digi + comp_qa
end

def translate
@user = User.find_by_id(params[:id])

avail_trans = Video.where(:translator_id => nil)
avail_digi = Video.where(:typer_id => nil)
avail_qa = Video.where(:qa_id => nil)
@avail = avail_trans + avail_digi + avail_qa

@trans_vids = Video.where(:translator_id => params[:id])
@digi_vids  = Video.where(:typer_id => params[:id])
@qa_vids = Video.where(:qa_id => params[:id])

comp_trans = Video.where(:translate_complete => true, :translator_id => params[:id])
comp_digi = Video.where(:type_complete => true, :typer_id => params[:id])
comp_qa = Video.where(:qa_complete => true, :qa_id => params[:id])
@comp = comp_trans + comp_digi + comp_qa
end

def digitize
@user = User.find_by_id(params[:id])

avail_trans = Video.where(:translator_id => nil)
avail_digi = Video.where(:typer_id => nil)
avail_qa = Video.where(:qa_id => nil)
@avail = avail_trans + avail_digi + avail_qa

@trans_vids = Video.where(:translator_id => params[:id])
@digi_vids  = Video.where(:typer_id => params[:id])
@qa_vids = Video.where(:qa_id => params[:id])

comp_trans = Video.where(:translate_complete => true, :translator_id => params[:id])
comp_digi = Video.where(:type_complete => true, :typer_id => params[:id])
comp_qa = Video.where(:qa_complete => true, :qa_id => params[:id])
@comp = comp_trans + comp_digi + comp_qa
end

def qa
@user = User.find_by_id(params[:id])

avail_trans = Video.where(:translator_id => nil)
avail_digi = Video.where(:typer_id => nil)
avail_qa = Video.where(:qa_id => nil)
@avail = avail_trans + avail_digi + avail_qa

@trans_vids = Video.where(:translator_id => params[:id])
@digi_vids  = Video.where(:typer_id => params[:id])
@qa_vids = Video.where(:qa_id => params[:id])

comp_trans = Video.where(:translate_complete => true, :translator_id => params[:id])
comp_digi = Video.where(:type_complete => true, :typer_id => params[:id])
comp_qa = Video.where(:qa_complete => true, :qa_id => params[:id])
@comp = comp_trans + comp_digi + comp_qa
end

def completed
@user = User.find_by_id(params[:id])

avail_trans = Video.where(:translator_id => nil)
avail_digi = Video.where(:typer_id => nil)
avail_qa = Video.where(:qa_id => nil)
@avail = avail_trans + avail_digi + avail_qa

@trans_vids = Video.where(:translator_id => params[:id])
@digi_vids  = Video.where(:typer_id => params[:id])
@qa_vids = Video.where(:qa_id => params[:id])

comp_trans = Video.where(:translate_complete => true, :translator_id => params[:id])
comp_digi = Video.where(:type_complete => true, :typer_id => params[:id])
comp_qa = Video.where(:qa_complete => true, :qa_id => params[:id])
@comp = comp_trans + comp_digi + comp_qa
end

end
