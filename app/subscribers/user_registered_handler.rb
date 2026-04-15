class UserRegisteredHandler
  def call(event)
    SendEmailsJob.set(wait: 1.minute).perform_later(User.find(event.data[:user_id]))
  end
end