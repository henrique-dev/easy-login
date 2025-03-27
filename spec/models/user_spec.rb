require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) { attributes_for(:user) }

  subject do
    described_class.new(user_params)
  end

  context 'with valid arguments' do
    it 'is a valid object' do
      expect(subject).to be_valid
    end

    it 'create an user' do
      expect do
        subject.save
      end.to change(User, :count).by(1)
    end

    it 'destroy an user' do
      subject.save
      expect do
        subject.destroy
      end.to change(User, :count).by(-1)
    end
  end

  context 'with invalid arguments' do
    it 'without name is not a valid object' do
      user_params.delete(:name)
      expect(subject).to_not be_valid
    end

    it 'without email is not a valid object' do
      user_params.delete(:email)
      expect(subject).to_not be_valid
    end

    it 'without password is not a valid object' do
      user_params.delete(:password)
      expect(subject).to_not be_valid
    end
  end
end
