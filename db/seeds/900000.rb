slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  position: 1,
  contents: '
    <div>
      „It\'s more fun to be competent”<br /><br />
      <span class="italic">- DHH</span>
    </div>
  '
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  position: 1,
  contents: '
    <div>
      „It\'s more fun to be CREATIVE”<br /><br />
      <span class="italic">- me</span>
    </div>
  '
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'partial_raw',
  contents: '/slides/seeds/qr_codes'
)


# slide = Slide.create!(title: 'How to stay creative?')
# slide.parts.create!(
#   part_type: 'heading',
#   position: 1,
#   contents: "Don't get stuck!"
# )
# slide.parts.create!(
#   part_type: 'list',
#   position: 2,
#   contents: '
#     <li>Keep it simple - be ready to rewrite in a week</li>
#     <li>When you hit a unique error - check if you have to fix it</li>
#     <li>Always start with deleting the database</li>
#   '
# )
