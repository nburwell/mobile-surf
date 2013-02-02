class FeedbackMailer < ActionMailer::Base
  # layout 'email'
  default :from => "'MustSurfNow.com' <notifications@mustsurfnow.com>"

  def feedback(name, comment)
    @name    = name
    @comment = comment

    mail(:to => 'nburwell@gmail.com', :subject => "MustSurfNow Feedback: from #{name}")
  end
end
