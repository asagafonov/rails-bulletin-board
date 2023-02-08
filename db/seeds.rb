# frozen_string_literal: true

10.times do
  Category.create(
    name: Faker::Commerce.unique.brand
  )
end

User.create(
  name: 'Andrey Agafonov',
  email: 'a.s.agafonov@yandex.ru',
  admin: true
)

100.times do
  bulletin = Bulletin.create(
    title: Faker::Lorem.sentence(word_count: 2),
    description: Faker::Lorem.paragraph,
    user_id: User.find_by(email: 'a.s.agafonov@yandex.ru').id,
    category_id: Category.all.map(&:id).sample,
    state: %w[draft under_moderation published rejected archived].sample
  )
  bulletin.image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/template_photo.png')),
    filename: 'template_photo.png',
    content_type: 'image/png'
  )
  bulletin.save!
end
