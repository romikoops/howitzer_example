FactoryGirl.define do
  factory :user do
    email { "u#{generate(:serial)}@#{settings.mailgun_domain}" }
    login nil
    first_name { "FirstName#{generate(:serial)}" }
    last_name { "LastName#{generate(:serial)}" }
    password { settings.def_test_pass }
  end
end
