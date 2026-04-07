require 'rails_helper'

describe BusPolicy do
  let(:bus) {Bus.create(name: "bus", bus_type: "sitter", capacity: 25, price: 500)}
  subject {BusPolicy.new(user, bus)}

  context 'when user is not guide' do
    let(:user) {User.create(name: "tester", email: "tester@gmail.com", phone: "9876543210", password: "Tester@123", role: "tourist")}

    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to_not permit_action(:create)}
    it {is_expected.to_not permit_action(:update)}
    it {is_expected.to_not permit_action(:destroy)}
  end

  context 'when user is guide' do
    let(:user) {User.create(name: "guide", email: "guide@gmail.com", phone: "9876543210", password: "Guide@123", role: "guide")}

    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to permit_action(:create)}
    it {is_expected.to permit_action(:update)}
    it {is_expected.to permit_action(:destroy)}
  end
end
