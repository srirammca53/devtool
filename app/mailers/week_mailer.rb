class WeekMailer < ActionMailer::Base
  default from: "from@example.com"
 def weekly_mail
    @user = User.find(:all, :select => "mail").map(&:mail)
    
   @user.each do |mail|
    mail(:to => @user, :subject => "Welcome to VisperTool Weekly status")
   end
  end
end
