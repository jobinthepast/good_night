require 'rails_helper'

RSpec.describe 'Sleep APIs', type: :request do
  let!(:user1) { FactoryBot.create(:user) }

  describe 'GET /api/v1/:user_id/clocked_ins' do
    before do
      3.times { FactoryBot.create(:sleep, user: user1) }

      get "/api/v1/#{user1.id}/clocked_ins"
    end

    it 'returns all the clocked-in JSON' do
      expect(JSON.parse(response.body)["sleepings"]).to eq(JSON.parse(user1.sleeps.order(:created_at).to_json))
    end
  end

  describe 'GET /api/v1/:user_id/friends_records' do
    before do
      friend1  = FactoryBot.create :user
      @friend2  = FactoryBot.create :user

      FactoryBot.create :following, user: user1, following_id: friend1.id
      FactoryBot.create :following, user: user1, following_id: @friend2.id

      @friend1_sleeps  = [FactoryBot.create(:sleep, user: friend1)]
      @friend2_sleeps  = [FactoryBot.create(:sleep, user: @friend2), FactoryBot.create(:sleep, user: @friend2, start_time: 10.days.ago, length: 7.hours)]

      stranger = FactoryBot.create :user
      @stranger_sleeps = [FactoryBot.create(:sleep, user: stranger)]

      get "/api/v1/#{user1.id}/friends_records"
    end

    it 'returns all friends sleeping records' do
      expect(JSON.parse(response.body)['sleepings']).to include(JSON.parse(@friend1_sleeps.to_json))
    end

    it 'returns only sleeping records within 1 week' do
      expect(JSON.parse(response.body)['sleepings']).to include(JSON.parse(@friend2.last_week_records.to_json))
    end

    it 'does not return non-friend sleeping records' do
      expect(JSON.parse(response.body)['sleepings']).not_to include(JSON.parse(@stranger_sleeps.to_json))
    end
  end
end
