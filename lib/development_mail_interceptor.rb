class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "*development_interceptor*Video Deadlines Approaching!"
    # message.to = "asafaa-22@hotmail.com"
  end
end