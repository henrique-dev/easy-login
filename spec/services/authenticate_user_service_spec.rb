require 'rails_helper'

RSpec.describe AuthenticateUserService, type: :service do
  let!(:params) { attributes_for(:user) }

  subject do
    described_class.call(params:)
  end

  before do
    User.create(**params)
    User.create(attributes_for(:user))
    User.create(attributes_for(:user))
    User.create(attributes_for(:user))
  end

  context 'with valid arguments' do
    it 'is a valid object' do
      expect(subject.errors).to eq({})
      expect(subject.success).to eq(true)
      expect(subject.object.name).to eq(params[:name])
      expect(subject.object.email).to eq(params[:email])
    end
  end

  context 'with invalid arguments' do
    context 'when validating the contract' do
      context 'validating the email' do
        context 'without email' do
          let(:params) { attributes_for(:user, email: nil) }

          it 'is not valid' do
            expect(subject.errors).to eq({ email: ['must be filled'] })
            expect(subject.success).to eq(false)
          end
        end

        context 'with many values in local-part@domain' do
          context 'when local-part has less than 1 character' do
            let(:params) { attributes_for(:user, email: Faker::Internet.email(name: '')) }

            it 'is not valid' do
              expect(subject.errors).to eq({ email: ['is not valid'] })
              expect(subject.success).to eq(false)
            end
          end

          context 'when local-part has more than 64 characters' do
            let(:params) do
              attributes_for(
                :user,
                email: Faker::Internet.email(name: Faker::Lorem.characters(number: 65))
              )
            end

            it 'is not valid' do
              expect(subject.errors).to eq({ email: ['is not valid'] })
              expect(subject.success).to eq(false)
            end
          end

          context 'when domain has less than 1 character' do
            let(:params) { attributes_for(:user, email: "#{Faker::Internet.email.split('@')[0]}@") }

            it 'is not valid' do
              expect(subject.errors).to eq({ email: ['is not valid'] })
              expect(subject.success).to eq(false)
            end
          end

          context 'when domain has more than 128 characters' do
            let(:params) do
              attributes_for(
                :user,
                email: Faker::Internet.email(domain: Faker::Lorem.characters(number: 129))
              )
            end

            it 'is not valid' do
              expect(subject.errors).to eq({ email: ['is not valid'] })
              expect(subject.success).to eq(false)
            end
          end

          context 'when domain has invalid chars' do
            let(:params) do
              attributes_for(
                :user,
                email: Faker::Internet.email(domain: 'a_')
              )
            end

            it 'is not valid' do
              expect(subject.errors).to eq({ email: ['is not valid'] })
              expect(subject.success).to eq(false)
            end
          end
        end
      end

      context 'validating the password' do
        context 'without password' do
          let(:params) { attributes_for(:user, password: nil) }

          it 'is not valid' do
            expect(subject.errors).to eq({ password: ['must be filled'] })
            expect(subject.success).to eq(false)
          end
        end

        context 'when the password has less than 2 numbers' do
          let(:params) { attributes_for(:user, password: '1@+ABcd_complex-password') }

          it 'is not valid' do
            expect(subject.errors).to eq({ password: ['must have at least 2 numbers'] })
            expect(subject.success).to eq(false)
          end
        end

        context 'when the password has less than 2 numbers' do
          let(:params) { attributes_for(:user, password: '@12ABcdcomplexpassword') }

          it 'is not valid' do
            expect(subject.errors).to eq({ password: ['must have at least 2 special chars'] })
            expect(subject.success).to eq(false)
          end
        end

        context 'when the password has less than 2 numbers' do
          let(:params) { attributes_for(:user, password: '12@+cd_complex-password') }

          it 'is not valid' do
            expect(subject.errors).to eq({ password: ['must have at least 2 uppercase letters'] })
            expect(subject.success).to eq(false)
          end
        end

        context 'when the password has less than 2 numbers' do
          let(:params) { attributes_for(:user, password: '12@+CD_COMPLEX-PASSWORD') }

          it 'is not valid' do
            expect(subject.errors).to eq({ password: ['must have at least 2 lowercase letters'] })
            expect(subject.success).to eq(false)
          end
        end
      end
    end
  end
end
