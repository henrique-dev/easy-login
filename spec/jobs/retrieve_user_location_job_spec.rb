require 'rails_helper'

RSpec.describe RetrieveUserLocationJob, type: :job do
  let(:ip_address) { Faker::Internet.public_ip_v4_address }
  let(:user) { User.create(attributes_for(:user)) }

  subject do
    described_class.perform_later(user.id, ip_address)
  end

  it 'perform an async job' do
    expect do
      subject
    end.to have_enqueued_job(RetrieveUserLocationJob).with(user.id, ip_address).on_queue('default')
  end

  it 'perform a job without error' do
    expect(RetrieveUserLocationService).to receive(:call)
    expect do
      described_class.new(user.id, ip_address).perform_now
    end.to_not raise_error
  end
end
