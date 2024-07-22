# == Schema Information
#
# Table name: profiles
#
#  id                   :integer          not null, primary key
#  bio                  :text
#  github_url           :string
#  in_app_notifications :boolean          default(TRUE), not null
#  is_public            :boolean          default(FALSE), not null
#  linkedin_url         :string
#  location             :string
#  mail_notifications   :boolean          default(TRUE), not null
#  name                 :string
#  profileable_type     :string           not null
#  twitter_url          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  profileable_id       :integer          not null
#
# Indexes
#
#  index_profiles_on_profileable  (profileable_type,profileable_id)
#
require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:profile) { build_stubbed(:profile, :with_user) }

  it "has a valid factory" do
    expect(profile).to be_valid
  end
end
