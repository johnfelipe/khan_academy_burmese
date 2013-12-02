class Reminder < ActionMailer::Base
  default from: "no-reply@khanacademy.org"

  def deadline_approaching(recipient)
  	@account = recipient
  	mail(to: "asafaa-22@hotmail.com", subject: "Video Deadlines Approaching!")
  end
end
