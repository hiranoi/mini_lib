class UserNotifier < ApplicationMailer
  default :from => 'xxx@example.com'

  def new_arrival_mail(to,from,subject)
    mail( :to => to,
    :from => from,
    :subject => subject )
  end	
end
