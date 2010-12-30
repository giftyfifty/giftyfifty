class UserMailer < ActionMailer::Base
  default :from => "no-reply@giftyfifty.com"
  
  def register_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to GiftyFifty!")
  end
  
  def test
    mail(:to => 'jparbros@hotmail.cp,', :subject => "Welcome to GiftyFifty!")
  end
end
