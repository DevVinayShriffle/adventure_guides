require 'rails_helper'

describe DestinationPolicy do
  let(:destination) {Destination.create!(name: 'destination', description: 'desc', location: 'location')}
  subject {DestinationPolicy.new(user, destination)}

  context 'when user is not admin' do
    let(:user) {User.create!(name: 'tester', email: 'tester@gmail.com', password: 'Test@123', role: 'tourist', phone: '9876543210')}

    it {is_expected.to permit_action(:show)}
    it {is_expected.to permit_action(:index)}
    it {is_expected.to_not permit_action(:create)}
    it {is_expected.to_not permit_action(:update)}
    it {is_expected.to_not permit_action(:destroy)}
  end

  context 'when user is admin' do
    let(:user) {User.create!(name: 'admin', email: 'admin@gmail.com', password: 'Admin@123', role: 'admin', phone: '9876543210')}
    # let(:destination) {create(:destination, user: user)}

    it {is_expected.to permit_action(:create)}
    it {is_expected.to permit_action(:update)}
    it {is_expected.to permit_action(:destroy)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to permit_action(:index)}
  end
end
