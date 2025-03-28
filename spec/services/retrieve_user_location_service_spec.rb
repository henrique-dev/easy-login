require 'rails_helper'

RSpec.describe RetrieveUserLocationService, type: :service, vcr: { match_requests_on: %i[path] } do
  let(:ip_address) { '6.245.34.61' }
  let!(:user) { User.create(attributes_for(:user)) }

  subject do
    described_class.call(user:, ip_address:)
  end

  context 'with valid arguments' do
    it 'is a valid object' do
      expect(subject.errors).to eq({})
      expect(subject.success).to eq(true)
    end
  end

  context 'with invalid arguments' do
    context 'with an invalid ip_address' do
      let(:ip_address) { 'invalid-ip-address' }

      it 'is not valid' do
        expect(subject.errors).to eq({ ip_address: ['Please provide a valid IP address'] })
        expect(subject.success).to eq(false)
      end
    end
  end
end
