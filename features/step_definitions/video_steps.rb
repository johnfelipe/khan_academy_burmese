Given /the following videos exist/ do |videos_table|
  videos_table.hashes.each do |video|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that video to the database here.
    Video.create(video)
  end
  
end