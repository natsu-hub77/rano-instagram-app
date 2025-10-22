# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account_name           :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_seen_at           :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_account_name          (account_name) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    account_name { Faker::Lorem.characters(number: 7) }
    email { Faker::Internet.email }
    password { 'password' }

  end
end
