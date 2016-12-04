# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MessageMailer, type: :mailer do
  let(:msg) { Message.new(name: 'Test Name', subject: 'Test Subject', content: 'Test Content', email: 'test@email.com') }
  let(:email) { MessageMailer.message_me(msg).deliver_now }
  let(:confirmation_email) { MessageMailer.message_me_confirmation(msg).deliver_now }

  describe 'message mailer' do
    it 'renders the subject' do
      expect(email.subject).to eq('Test Subject')
    end

    context 'renders the message' do
      it 'renders username in body' do
        expect(email.body.encoded).to match('Test Name')
      end
      it 'render content in body' do
        expect(email.body.encoded).to match('Test Content')
      end
    end

    it 'renders the email' do
      expect(email.from).to eq(['test@email.com'])
    end
  end

  describe 'confirmation message' do
    it 'renders the subject' do
      expect(confirmation_email.subject).to eq('Test Subject')
    end

    context 'renders the message' do
      it 'renders username in body' do
        expect(email.body.encoded).to match('Test Name')
      end
      it 'render content in body' do
        expect(email.body.encoded).to match('Test Content')
      end
    end

    it 'renders the email' do
      expect(confirmation_email.to).to eq(['test@email.com'])
    end
  end
end
