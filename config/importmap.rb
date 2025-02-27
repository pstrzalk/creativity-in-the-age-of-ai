# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "three", to: "https://unpkg.com/three@0.171.0/build/three.module.js"
pin "three/controls/orbit", to: "https://unpkg.com/three@0.171.0/examples/jsm/controls/OrbitControls.js"
pin "three/loaders/gltf", to: "https://unpkg.com/three@0.171.0/examples/jsm/loaders/GLTFLoader.js"
pin "three/loaders/draco", to: "https://unpkg.com/three@0.171.0/examples/jsm/loaders/DRACOLoader.js"
# pin "three/animation/tracks/vector_key", to: "https://unpkg.com/three@0.171.0/src/animation/tracks/VectorKeyframeTrack.js"
