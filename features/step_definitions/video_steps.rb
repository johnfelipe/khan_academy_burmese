Given /the following videos exist/ do |videos_table|
  videos_table.hashes.each do |video|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that video to the database here.
    v = Video.create(video)
    v.update_attributes(
      :due_date => Date.parse('01-01-1970')
    )
  end
  
end