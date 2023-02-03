# frozen_string_literal: true

class AddAdmins < ActiveRecord::Migration[7.0]
  def change
    User.find_by(email: 'a.s.agafonov@yandex.ru').update(admin: true)
  end
end
