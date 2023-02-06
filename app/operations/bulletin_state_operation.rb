# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

class BulletinStateOperation
  def call(bulletin:, key:)
    case key
    when 'to_moderation'
      bulletin.to_moderation!
    when 'publish'
      bulletin.publish!
    when 'reject'
      bulletin.reject!
    when 'archive'
      bulletin.archive!
    else
      false
    end
  end
end

# rubocop:enable Metrics/MethodLength
