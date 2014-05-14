class UserMailer < ActionMailer::Base
  default :from => "no-reply@eot-ukraine.su"

  def forgot_password(user, key)
    @user, @key, @protocol = user, key, protocol
    mail( :subject => "#{app_name} -- forgotten password",
          :to      => user.email_address )
  end

  def invite(user, key)
    @user, @key, @protocol = user, key, protocol
    mail( :subject => "Invitation to #{app_name}",
          :to      => user.email_address )
  end

  private

  def protocol
    Thread.current[:request].scheme
  end
end
