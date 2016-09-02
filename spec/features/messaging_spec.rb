# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'mailboxer messaging', type: :feature do
  it 'can send a message' do
    user = create(:user)
    user2 = create(:user)
    login_as user
    visit new_conversation_path

    chosen_select(user2.username, from: :conversation_recipients)
    fill_in 'Subject', with: 'Message Subject'
    fill_in :conversation_body, with: 'Message body to user2'
    click_on 'Send Message'

    expect(user.mailbox.sentbox.count).to eq(1)
    expect(user2.mailbox.inbox.count).to eq(1)
  end

  it 'can send a message to multiple recipients' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    login_as user
    visit new_conversation_path

    chosen_select(user2.username, user3.username, from: :conversation_recipients)
    fill_in 'Subject', with: 'Message Subject'
    fill_in :conversation_body, with: 'Message body to user2'
    click_on 'Send Message'

    expect(user.mailbox.sentbox.count).to eq(1)
    expect(user2.mailbox.inbox.count).to eq(1)
    expect(user3.mailbox.inbox.count).to eq(1)
  end

  it 'can reply to a message' do
    user = create(:user)
    user2 = create(:user)
    login_as user
    user2.send_message(user, 'test body', 'test subject')
    visit mailbox_inbox_path
    expect(user.mailbox.inbox.count).to eq(1)
    expect(user2.mailbox.sentbox.count).to eq(1)
    click_on 'View'
    fill_in :message_body, with: 'Test reply message'
    click_on 'Reply'
    expect(user2.mailbox.inbox.count).to eq(1)
  end

  it 'can have user recipient prefilled from profile page' do
    user = create(:user)
    user2 = create(:user)
    login_as user
    visit show_user_path(user2.username)
    click_on 'Message'
    expect(page).to have_current_path(new_conversation_path(user: user2.username))
  end

  it 'move message to trash' do
    user = create(:user)
    user2 = create(:user)
    login_as user
    user2.send_message(user, 'test body', 'test subject')
    visit mailbox_inbox_path
    expect(user.mailbox.inbox.count).to eq(1)
    expect(user2.mailbox.sentbox.count).to eq(1)
    click_on 'View'
    click_on 'Move to trash'
    expect(user.mailbox.trash.count).to eq(1)
  end

  it 'untrash a message' do
    user = create(:user)
    user2 = create(:user)
    login_as user
    user2.send_message(user, 'test body', 'test subject')
    visit mailbox_inbox_path
    expect(user.mailbox.inbox.count).to eq(1)
    expect(user2.mailbox.sentbox.count).to eq(1)
    click_on 'View'
    click_on 'Move to trash'
    click_on 'Trash'
    click_on 'View'
    click_on 'Untrash'
    expect(user.mailbox.inbox.count).to eq(1)
  end
end
