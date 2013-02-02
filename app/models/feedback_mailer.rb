class FeedbackMailer < ActionMailer::Base
  # layout 'email'
  default :from => "'MustSurfNow.com' <notifications@mustsurfnow.com>"

  def feedback(name, comment, page)
    @name    = name
    @comment = comment
    @page    = page

    mail(:to => 'nburwell@gmail.com, primiti@gmail.com, vu@ringrevenue.com, chris@ringrevenue.com', :subject => "MustSurfNow Feedback: from #{name}")
  end
end
