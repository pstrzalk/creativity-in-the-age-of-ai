slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'The state of the web in 2025<br />How did we get here?'
)

slide = Slide.create!(title: 'The first website')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/first_website_0'
)

slide = Slide.create!(title: 'The first website')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/first_website_1'
)

slide = Slide.create!(title: 'The first website')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/first_website_2'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'image',
  position: 1,
  contents: '/graphics/first_website_is_a_newspaper.webp'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  position: 1,
  contents: 'Nothing has changed<br />in the user <-> web interaction<br />for the next 34 years'
)

slide = Slide.create!(title: '34 years of... progress?')
slide.parts.create!(
  part_type: 'list',
  contents: '
    <li>1991 - The first website</li>
    <li>1992 - The first image</li>
    <li>1993 - The first audio</li>
    <li>1995 - The first video</li>
    <li>1996 - (my first website) Animated GIFs, Flash and Java Applets</li>
    <li>1997 - Streaming audio/video</li>
    <li>2000s - 3D graphics in 2000s (WebGL in 2011)</li>
    <li>2009 - ES5, finally some decent JavaScript</li>
    <li>2018 - WebXR</li>
  '
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'image',
  position: 1,
  contents: '/graphics/modern_website_is_a_magazine.webp'
)

slide = Slide.create!(title: "It takes time and creativity")
slide.parts.create!(
  part_type: 'container',
  position: 1,
  contents: '<br /><span class="text-5xl">„It took 20 years for television to evolve away from radio”</span><br /><span class="italic">- Steve Jobs</span>'
)
slide.parts.create!(
  part_type: 'container',
  position: 2,
  contents: '<br /><span class="text-5xl">„The first TV shows are basically radio shows with a television camera pointed at them”</span><br /><span class="italic">- also Steve Jobs</span>'
)

slide = Slide.create!(title: 'Web became Software')
slide.parts.create!(
  part_type: 'list',
  contents: '
    <li>Google Docs</li>
    <li>e-Commerce</li>
    <li>e-Learning</li>
    <li>e-Medicine</li>
    <li>Much of the software which used to be desktop-only</li>
    <li>... and much, much more</li>
  '
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'image',
  position: 1,
  contents: '/graphics/landline_to_mobile_1.webp'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'image',
  position: 1,
  contents: '/graphics/landline_to_mobile_2.webp'
)
