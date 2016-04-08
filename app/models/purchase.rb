class Purchase < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :city

  validates :name, presence: true, length: { minimum: 10 }
  validate :date_cannot_be_in_the_past

  scope :active, -> { where(status: "active") }
  scope :inactive, -> { where(status: "inactive") }

  def date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end
end

# == Schema Information
#
# Table name: purchases
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  end_date    :date
#  status      :string
#  group_id    :integer
#  owner_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :integer
#
# Indexes
#
#  index_purchases_on_city_id  (city_id)
#
