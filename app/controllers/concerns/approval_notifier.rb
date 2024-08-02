module ApprovalNotifier
  extend ActiveSupport::Concern
  included do
    after_action :notify_user_approval, only: %i[approve_user]
  end

  def notify_user_approval
    return unless @user.persisted? && @user.is_pending == false

    nil unless UserMailer.email_user(@user).deliver_now
  end
end
