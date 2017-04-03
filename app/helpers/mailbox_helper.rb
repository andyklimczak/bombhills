# frozen_string_literal: true

module MailboxHelper
  def unread_messages_count
    # how to get the number of unread messages for the current user
    # using mailboxer
    mailbox.inbox(unread: true).distinct.count(:id)
  end
end
