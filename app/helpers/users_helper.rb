# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

module UsersHelper
  def self.translate_state(bulletin_state)
    case bulletin_state
    when 'draft'
      ::I18n.t('bulletins.state.draft')
    when 'under_moderation'
      ::I18n.t('bulletins.state.under_moderation')
    when 'published'
      ::I18n.t('bulletins.state.published')
    when 'archived'
      ::I18n.t('bulletins.state.archived')
    else
      ''
    end
  end
end

# rubocop:enable Metrics/MethodLength
