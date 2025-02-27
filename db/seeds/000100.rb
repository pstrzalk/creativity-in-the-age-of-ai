slide = Slide.create!
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/title'
)
