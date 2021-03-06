# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignupMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:mail) { SignupMailer.signup_notification(user).deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq('You signed up')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['notifications@bombhills.com'])
  end

  it 'assigns user' do
    expect(mail.body.encoded).to match(user.name)
  end
end
