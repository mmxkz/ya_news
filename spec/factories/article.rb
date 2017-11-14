FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:annotation) { |n| "Annotation #{n}" }
    published_at Time.now
  end
end
