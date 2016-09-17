# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MessageMailer, type: :mailer do
  before(:all) do
    msg = Message.new(name: 'Test Name', subject: 'Test Subject', content: 'Test Content', email: 'test@email.com')
    @email = MessageMailer.message_me(msg).deliver_now
    @confirmation_email = MessageMailer.message_me_confirmation(msg).deliver_now
  end

  describe 'message mailer' do
    it 'renders the subject' do
      expect(@email.subject).to eq('Test Subject')
    end

    it 'renders the message' do
      expect(@email.body.encoded).to match('Test Name')
      expect(@email.body.encoded).to match('Test Content')
    end

    it 'renders the email' do
      expect(@email.from).to eq(['test@email.com'])
    end
  end

  describe 'confirmation message' do
    it 'renders the subject' do
      expect(@confirmation_email.subject).to eq('Test Subject')
    end

    it 'renders the message' do
      expect(@confirmation_email.body.encoded).to match('Test Name')
      expect(@confirmation_email.body.encoded).to match('Test Content')
    end

    it 'renders the email' do
      expect(@confirmation_email.to).to eq(['test@email.com'])
    end
  end
end
