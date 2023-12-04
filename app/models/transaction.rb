class Transaction < ApplicationRecord
  TRANSFER = 'transfer'
  DEPOSIT = 'deposit'
  WITHDRAW = 'withdraw'

  enum transaction_type: { transfer: 'transfer', deposit: 'deposit', withdraw: 'withdraw' }

  belongs_to :source, polymorphic: true, optional: true
  belongs_to :target, polymorphic: true, optional: true

  validates_presence_of :currency, :transaction_type
  validates_presence_of :source, if: -> { transfer? || withdraw? }
  validates_presence_of :target, if: -> { transfer? || deposit? }
  validates :source_type, inclusion: %w[User Team Stock], if: -> { transfer? || withdraw? }
  validates :target_type, inclusion: %w[User Team Stock], if: -> { transfer? || deposit? }

  validates :amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :currency, inclusion: %w[USD JPY CHF GBP EUR]

  validate :sufficient_balance?, on: :create

  after_create :reset_balance_cache

  def readonly?
    new_record? ? false : true
  end

  private

  def reset_balance_cache
    Rails.cache.delete(source.balance_cache_key(currency)) if source.present?
    Rails.cache.delete(target.balance_cache_key(currency)) if target.present?
  end

  def sufficient_balance?
    return true if deposit?

    errors.add(:base, 'Insufficient balance') if amount > source.balance(currency)
  end
end
