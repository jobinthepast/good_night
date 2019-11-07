FactoryBot.define do
  factory :sleep do
    user

    start_time { rand(5).days.ago.beginning_of_day - rand(5).hours }
    length     { rand(5..10) }
    end_time   { start_time + length.hours }
  end
end
