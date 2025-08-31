class CommentMailer < ApplicationMailer
  def new_comment(user)
    @user = user
    mail to: user.email, subject: '【お知らせ】コメントが投稿されました'
  end
end