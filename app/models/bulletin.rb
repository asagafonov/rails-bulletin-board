# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM
  has_one_attached :image

  belongs_to :user
  belongs_to :category

  alias_attribute :state, :aasm_state
  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderation do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions to: :archived
    end
  end

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  scope :already_published, -> { where(state: :published) }
  scope :by_creation_date_desc, -> { order(created_at: :desc) }
end
