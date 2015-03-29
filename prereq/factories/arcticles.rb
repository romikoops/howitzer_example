FactoryGirl.define do
  factory :article do
    title { "Article title #{generate(:serial)}"}
    body { 'Test text' }
  end
end
