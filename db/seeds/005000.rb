slide = Slide.create!(title: "It is just a start")
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/huggingface'
)

slide = Slide.create!(title: "Use LLMs to build software")
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/build_software_1'
)

slide = Slide.create!(title: "Handle real hardware")
slide.parts.create!(
  part_type: 'image',
  position: 1,
  contents: '/graphics/barcode.webp'
)

slide = Slide.create!(title: 'Use 3D graphics')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/choose_your_pet'
)

slide = Slide.create!(title: "What will you say when...")
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/kiosk_project_1'
)

slide = Slide.create!(title: "What will you say when...")
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/kiosk_project_2'
)
