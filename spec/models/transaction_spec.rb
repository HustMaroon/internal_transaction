# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    let!(:user) { create(:user) }

    before do
      create(:transaction, :deposit, target: user, target_type: 'User')
    end

    context 'balance sufficient' do
      let(:tx) { build(:transaction, :transfer, source: user, source_type: 'User')}

      it 'should be valid' do
        expect(tx).to be_valid
      end
    end

    context 'balance insufficient' do
      let(:tx) { build(:transaction, :transfer, source: user, source_type: 'User', amount: BigDecimal('200'))}

      it 'should not be valid' do
        expect(tx).not_to be_valid
        expect(tx.errors.full_messages).to eq(['Insufficient balance'])
      end
    end
  end
end
