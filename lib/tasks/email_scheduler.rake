namespace :email do
  desc "Send welcome emails to users who signed up recently"
  task send_welcome_emails: :environment do
    users_to_email = User.where("created_at >= ?", 3.minutes.ago)

    users_to_email.each do |user|
      UserMailer.welcome_email(user).deliver
      puts "Enqueued welcome email for #{user.email}"
    end
  end
end
