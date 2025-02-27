slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'Creativity in and through RoR<br />(my attempts)'
)

slide = Slide.create!(title: 'Domain-Driven Design in Rails')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/ddd'
)

slide = Slide.create!(title: 'Real time games in Rails')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/tetris'
)

slide = Slide.create!(title: 'Presentation Platform in Rails')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/presentation_in_rails'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'But it was never enough'
)
