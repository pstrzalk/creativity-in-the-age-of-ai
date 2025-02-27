slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: '<br />Image Recognition<br /><br />'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'LLM-Driven<br />Image Recognition<br /><br />'
)


slide = Slide.create!(title: "Image Capture in Rails")
slide.parts.create!(
  part_type: 'partial_raw',
  position: 1,
  contents: 'images/take_a_selfie'
)

slide = Slide.create!(title: "Image Recognition")
slide.parts.create!(
  part_type: 'partial_raw',
  position: 1,
  contents: 'slides/seeds/vector_search'
)

slide = Slide.create!(title: 'What is in this image, LLM?')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_to_text_1'
)

slide = Slide.create!(title: 'What is in this image, LLM?')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_to_text_2'
)

slide = Slide.create!(title: 'Image Recognition')
slide.parts.create!(
  part_type: 'container',
  position: 1,
  contents: 'We can use it for:'
)

slide.parts.create!(
  part_type: 'list',
  contents: "
    <li>Validating contents of uploaded user-facing images</li>
    <li>Processing security cameras' footage (from warehouses to child protection)</li>
    <li>Allowing only smiling profile pictures</li>
  "
)

slide = Slide.create!(title: 'Embeddings')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_0'
)

slide = Slide.create!(title: 'Embeddings')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_1'
)

slide = Slide.create!(title: 'Embeddings')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_2'
)

slide = Slide.create!(title: 'Embeddings')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_3'
)

slide = Slide.create!(title: 'Embeddings')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_4'
)

slide = Slide.create!(title: 'Store Embeddings in Ruby on Rails')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_6'
)

slide = Slide.create!(title: 'Query using Embeddings')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_7'
)

slide = Slide.create!(title: 'Query using Embeddings')
slide.parts.create!(
  part_type: 'partial',
  contents: '/slides/seeds/image_recognition_how_to_8'
)

slide = Slide.create!(title: "Vector Search")
slide.parts.create!(
  part_type: 'partial_raw',
  position: 1,
  contents: 'slides/seeds/vector_search'
)
