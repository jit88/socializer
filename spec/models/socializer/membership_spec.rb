require 'spec_helper'

module Socializer
  describe Membership, :type => :model do
    let(:membership) { build(:socializer_membership) }

    it 'has a valid factory' do
      expect(membership).to be_valid
    end

    context 'mass assignment' do
      it { expect(membership).to allow_mass_assignment_of(:group_id) }
    end

    context 'relationships' do
      it { expect(membership).to belong_to(:group) }
      it { expect(membership).to belong_to(:activity_member) }
      # it { expect(membership).to belong_to(:activity_member).class_name('ActivityObject').with_foreign_key('member_id') }
    end

    context '#member' do
      it { expect(membership).to respond_to(:member) }
      # let(:activitable) { membership.activity_member.activitable }
      # it { expect(membership.member).to be_a(activitable.class) }
      # it { expect(membership.member).to eq(activitable) }
    end

    context '#approve!' do
      it { expect(membership).to respond_to(:approve!) }
    end

    context '#confirm!' do
      it { expect(membership).to respond_to(:confirm!) }
    end

    context '#decline!' do
      it { expect(membership).to respond_to(:decline!) }
    end

    context 'when approved' do
      let(:inactive_membership) { create(:socializer_membership, active: false) }

      before do
        inactive_membership.approve!
      end

      it 'becomes active' do
        expect(inactive_membership.active).to be_truthy
      end
    end

    context 'when confirmed' do
      let(:inactive_membership) { create(:socializer_membership, active: false) }

      before do
        inactive_membership.confirm!
      end

      it 'becomes active' do
        expect(inactive_membership.active).to be_truthy
      end
    end

    context 'when declined' do
      let(:inactive_membership) { create(:socializer_membership, active: false) }

      before do
        inactive_membership.decline!
      end

      it 'no longer exists' do
        expect { inactive_membership.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end
end
