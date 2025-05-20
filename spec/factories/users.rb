FactoryBot.define do
    factory :user do
        first_name { "John" }
        last_name { "Doe" }
        birth_date { "1997-12-04" }
        email { "john.doe@email.com" }
        password { "password" }
    end
end
