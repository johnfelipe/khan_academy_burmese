# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [{:name => 'User1 Lastname', :email => 'user1@example.com', :password => 'password'},
         {:name => 'User2', :email => 'user2@example.com', :password => 'password'},
         {:name => 'User3', :email => 'user3@example.com', :password => 'password'},
         {:name => 'User4', :email => 'user4@example.com', :password => 'password'},
         {:name => 'User5', :email => 'user5@example.com', :password => 'password'},
         {:name => 'User6', :email => 'user6@example.com', :password => 'password'},
         {:name => 'User7', :email => 'user7@example.com', :password => 'password'},
         {:name => 'User8', :email => 'user8@example.com', :password => 'password'},
         {:name => 'User9', :email => 'user9@example.com', :password => 'password'},
         {:name => 'User10', :email => 'user10@example.com', :password => 'password'},
         {:name => 'User11', :email => 'user11@example.com', :password => 'password'},
         {:name => 'User12', :email => 'user12@example.com', :password => 'password'},
         {:name => 'User13', :email => 'user13@example.com', :password => 'password'},
         {:name => 'User14', :email => 'user14@example.com', :password => 'password'},
         {:name => 'User15', :email => 'user15@example.com', :password => 'password'},
         {:name => 'User16', :email => 'user16@example.com', :password => 'password'},
         {:name => 'User17', :email => 'user17@example.com', :password => 'password'},
         {:name => 'User18', :email => 'user18@example.com', :password => 'password'},
         {:name => 'User19', :email => 'user19@example.com', :password => 'password'},
         {:name => 'User20', :email => 'user20@example.com', :password => 'password'},
     ]

videos = [{:video_id => 'Video1', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra', :translator_id => nil, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'false', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video2', :subject => 'Math', :course => 'Geometry', :title => 'I love Geometry', :translator_id => 1, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'true', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video3', :subject => 'Math', :course => 'Calculus', :title => 'I love Calculus', :translator_id => 1, 
            :typer_id => 1, :qa_id => nil, :translate_complete => 'true', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video4', :subject => 'Math', :course => 'Linear Algebra', :title => 'I love Linear Algebra', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'},
          {:video_id => 'Video5', :subject => 'Math', :course => 'Multivariable Calculus', :title => 'I love Multivariable Calculus', :translator_id => nil, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'false', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video6', :subject => 'Math', :course => 'Discrete Math', :title => 'I love Discrete Math', :translator_id => nil, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'false', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video7', :subject => 'Math', :course => 'Pre-Algebra', :title => 'I love Pre-Algebra', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'true'},
          {:video_id => 'Video8', :subject => 'Math', :course => 'Arithmetic', :title => 'I love Arithmetic', :translator_id => 1, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'true', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video9', :subject => 'Math', :course => 'Pre-Calculus', :title => 'I love Pre-Calculus', :translator_id => 1, 
            :typer_id => 1, :qa_id => nil, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'},
          {:video_id => 'Video10', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 2', :translator_id => 1, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'true', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video11', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 3', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'true'},
          {:video_id => 'Video12', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 4', :translator_id => 1, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'false', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video13', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 5', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'true'},
          {:video_id => 'Video14', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 6', :translator_id => 1, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'true', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video15', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 7', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'},
          {:video_id => 'Video16', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 8', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'true'},
          {:video_id => 'Video17', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 9', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'true'},
          {:video_id => 'Video18', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 10', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'},
          {:video_id => 'Video19', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 11', :translator_id => 1, 
            :typer_id => 1, :qa_id => 1, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'true'},
          {:video_id => 'Video21', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 13', :translator_id => nil, 
            :typer_id => nil, :qa_id => nil, :translate_complete => 'false', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video22', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 14', :translator_id => 1, 
            :typer_id => 1, :qa_id => nil, :translate_complete => 'false', :type_complete => 'false', :qa_complete => 'false'},
          {:video_id => 'Video23', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 15', :translator_id => 1, 
            :typer_id => 1, :qa_id => nil, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'},
          {:video_id => 'Video24', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 14', :translator_id => 1, 
            :typer_id => 1, :qa_id => nil, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'},
          {:video_id => 'Video25', :subject => 'Math', :course => 'Algebra', :title => 'I love algebra 16', :translator_id => 1, 
            :typer_id => 1, :qa_id => nil, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'},
          {:video_id => 'Video26', :subject => 'Math', :course => 'Calculus', :title => 'Calc 1B', :translator_id => 1, 
            :typer_id => 1, :qa_id => nil, :translate_complete => 'true', :type_complete => 'true', :qa_complete => 'false'}
     ]

users.each do |user|
  User.create(user)
end

videos.each do |video|
  Video.create(video)
end