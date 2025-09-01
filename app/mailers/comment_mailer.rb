class CommentMailer < ApplicationMailer
  def new_comment(comment, mentionee, mentioner)
    @comment = comment
    @mentionee = mentionee
    @mentioner = mentioner
    @post = comment.post

    mail to: @mentionee.email, subject: '【お知らせ】コメントでメンションされました'
  end
end