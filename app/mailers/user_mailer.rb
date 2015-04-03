class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "CocinitApp! Activa tu cuenta!"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "CocinitApp! Resetea tu password!"
  end
end
