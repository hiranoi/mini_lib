class UserNotifier < ApplicationMailer

  def new_arrival_mail(to,from,subject,categories,articles_array)

  	@articles_array = articles_array
  	@categories = categories

    mail( :to => to,
    :from => from,
    :subject => subject )
  end	
end
