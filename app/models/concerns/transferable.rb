# frozen_string_literal: true

module Transferable
  extend ActiveSupport::Concern

  included do
    has_many :debit_transactions, as: :source, class_name: 'Transaction', dependent: :restrict_with_exception
    has_many :credit_transactions, as: :target, class_name: 'Transaction', dependent: :restrict_with_exception
  end

  def transfer_to(entity, amount, currency)
    with_lock do
      update(last_tx_timestamp: Time.current)
      debit_transactions.create!(
        target: entity,
        target_type: entity.class.name,
        amount: amount,
        currency: currency,
        transaction_type: Transaction::TRANSFER
      )
    end
  end

  def balance(currency)
    Rails.cache.fetch(balance_cache_key(currency)) do
      credit_transactions.where(currency: currency).sum(:amount) - debit_transactions.where(currency: currency).sum(:amount)
    end
  end

  def balance_cache_key(currency)
    "BALANCE_#{self.class.name.upcase}_#{id}_#{currency}"
  end
end
