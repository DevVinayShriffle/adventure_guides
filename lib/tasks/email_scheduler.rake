namespace :email do
  desc "Send welcome emails to users who signed up recently"
  task send_welcome_emails: :environment do
    require 'byebug'
    # byebug
    # Example logic: Find users who signed up within the last 2 minutes and haven't received an email
    # The exact time range (e.g., 1 minute) depends on how frequently your cron job runs.
    users_to_email = User.where("created_at >= ?", 3.minutes.ago)
    # users_to_email = User.last

    users_to_email.each do |user|
      # Enqueue the email using your existing mailer/worker setup
      # Assuming you have a UserMailer with a welcome_email method
      UserMailer.welcome_email(user).deliver
      puts "Enqueued welcome email for #{user.email}"
    end
  end
end
