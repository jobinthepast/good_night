require 'rails_helper'

RSpec.describe 'User APIs', type: :request do
  let!(:user)   { FactoryBot.create(:user) }
  let!(:friend) { FactoryBot.create(:user) }

  describe 'POST /api/v1/:user_id/follow/:following_id' do
    it 'returns JSON with status ok' do
      post "/api/v1/#{user.id}/follow/#{friend.id}"

      expect(JSON.parse(response.body)["status"]).to eq("ok")
    end

    it 'returns JSON with status not_found' do
      post "/api/v1/-1/follow/100"

      expect(JSON.parse(response.body)["status"]).to eq("not_found")
    end
  end

  describe 'DELETE /api/v1/:user_id/unfollow/:following_id' do
    before { FactoryBot.create :following, user: user, following_id: friend.id }

    it 'returns JSON with status ok' do
      delete "/api/v1/#{user.id}/unfollow/#{friend.id}"

      expect(JSON.parse(response.body)["status"]).to eq("ok")
    end

    it 'returns JSON with status not_found' do
      delete "/api/v1/#{user.id}/unfollow/-1"

      expect(JSON.parse(response.body)["status"]).to eq("not_found")
    end
  end

  describe 'POST /api/v1/:user_id/sleep' do
    it 'returns JSON with status ok' do
      post "/api/v1/#{user.id}/sleep"

      expect(JSON.parse(response.body)["status"]).to eq("ok")
    end

    it 'returns JSON with status not_found' do
      post "/api/v1/-1/sleep"

      expect(JSON.parse(response.body)["status"]).to eq("not_found")
    end
  end

  describe 'POST /api/v1/:user_id/wake_up' do
    it 'returns JSON with status ok' do
      FactoryBot.create(:sleep, start_time: 10.hours.ago, end_time: nil, length: nil, user: user)

      post "/api/v1/#{user.id}/wake_up"

      expect(JSON.parse(response.body)["status"]).to eq("ok")
    end

    it 'returns JSON with status not_found' do
      post "/api/v1/#{user.id}/wake_up"

      expect(JSON.parse(response.body)["status"]).to eq("not_found")
    end

    it 'returns JSON with status not_found' do
      post "/api/v1/-1/wake_up"

      expect(JSON.parse(response.body)["status"]).to eq("not_found")
    end
  end
end
