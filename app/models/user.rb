# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins

  validates :name, :email, presence: true
end
