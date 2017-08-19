class UserNotifier < ApplicationMailer

  def new_arrival_mail(to,from,subject,articles)

  	@articles = articles

    mail( :to => to,
    :from => from,
    :subject => subject )
  end	
end
