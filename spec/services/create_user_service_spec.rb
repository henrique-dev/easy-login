require 'rails_helper'

RSpec.describe CreateUserService, type: :service do
  let(:params) { attributes_for(:user) }

  subject do
    described_class.call(params:)
  end

  context 'with valid arguments' do
    it 'is a valid object' do
      expect(subject.errors).to eq({})
      expect(subject.success).to eq(true)
      expect(subject.object.name).to eq(params[:name])
      expect(subject.object.email).to eq(params[:email])
      expect(subject.object.password).to_not eq(nil)
    end

    it 'create a User' do
      expect do
        subject
      end.to change(User, :count).by(1)
    end
  end

  context 'with invalid arguments' do
    context 'when validating the contract' do
      context 'validating the name' do
        context 'without name' do
          let(:params) { attributes_for(:user, name: nil) }

          it 'is not valid' do
            expect(subject.errors).to eq({ name: ['must be filled'] })
            expect(subject.success).to eq(false)
          end
        end

        context 'with less than 5 characters' do
          let(:params) { attributes_for(:user, name: Faker::Name.name[0, 4]) }

          it 'is not valid' do
            expect(subject.errors).to eq({ name: ['size cannot be less than 5'] })
            expect(subject.success).to eq(false)
          end
        end

        context 'with more than 128 characters' do
          let(:params) { attributes_for(:user, name: Faker::Lorem.characters(number: 129)) }

          it 'is not valid' do
            expect(subject.errors).to eq({ name: ['size cannot be greater than 128'] })
            expect(subject.success).to eq(false)
          end
        end
      end

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
      end
    end
  end
end
