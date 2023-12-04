# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    currency { 'USD' }
    amount { BigDecimal('100') }

    trait :deposit do
      target { create(:user)}
      target_type { 'User' }
      transaction_type { Transaction::DEPOSIT }
    end

    trait :withdraw do
      source { create(:user) }
      source_type { 'User' }
      transaction_type { Transaction::WITHDRAW }
    end

    trait :transfer do
      source { create(:user) }
      source_type { 'User' }
      target { create(:user)}
      target_type { 'User' }
      transaction_type { Transaction::TRANSFER }
    end
  end
end
