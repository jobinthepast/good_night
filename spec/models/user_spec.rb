require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:followings).dependent(:destroy) }
  it { should have_many(:sleeps).dependent(:destroy) }

  let!(:user)   { FactoryBot.create :user }
  let!(:sleep1) { FactoryBot.create :sleep, user: user }
  let!(:sleep2) { FactoryBot.create :sleep, user: user }
  let!(:sleep3) { FactoryBot.create :sleep, user: user }

  it 'retrieves the last sleep created' do
    expect(user.last_sleep).to eq(sleep3)
  end

  it 'retrieves only the last week sleep records' do
    sleep4 = FactoryBot.create :sleep, user: user, start_time: 10.days.ago

    expect(user.last_week_records).to match_array([sleep1, sleep2, sleep3])
  end
end
