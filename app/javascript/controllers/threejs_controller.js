import { Controller } from "@hotwired/stimulus";
import * as THREE from "three";
import { GLTFLoader } from 'three/loaders/gltf';

export default class extends Controller {
  connect() {
    var mixer;
    var clock = new THREE.Clock();
    var renderer = new THREE.WebGLRenderer( { antialias: true, alpha: true } );

    var scene = new THREE.Scene();
    var model;
    var windowRatio = window.innerWidth / window.innerHeight;
    var camera = new THREE.PerspectiveCamera(20, windowRatio);
    camera.position.set(0, 0, 7);

    let moveAction;

    const animate = function() {
      requestAnimationFrame(animate.bind(this));
      // this.controls.update();
      var delta = clock.getDelta();

      if (mixer) {
        mixer.update( delta );
      }

      renderer.render(scene, camera);
    }

    // this.renderer = new THREE.WebGLRenderer();

    renderer.setPixelRatio( window.devicePixelRatio );
    renderer.setSize( window.innerWidth, window.innerHeight );
    renderer.toneMapping = THREE.ACESFilmicToneMapping;
    renderer.toneMappingExposure = 0.8;
    renderer.outputEncoding = THREE.sRGBEncoding;

    renderer.domElement.classList.add("canvas3d");
    // renderer.setSize(this.element.style.width, this.element.style.height);

    this.element.appendChild(renderer.domElement);

    // var threejsWrapper = document.querySelector(".threejs-wrapper")
    // threejsWrapper.appendChild(renderer.domElement);

    const loader = new GLTFLoader();

    // Load a glTF resource
    loader.load(
      '/corgi_gltf/scene.gltf',
      function ( gltf ) {
        console.log("Model loaded");
        // Apply material to the model
        model = gltf.scene;
        window.model = model;

        scene.add( model );

        model.scale.set(1, 5/3, 1);

        const textureLoader = new THREE.TextureLoader();
        const baseColor = textureLoader.load('/corgi_gltf/textures/Corgi_baseColor.png');
        const normalMap = textureLoader.load('/corgi_gltf/textures/Corgi_normal.png');

        baseColor.flipY = false;
        normalMap.flipY = false;

        model.traverse((child) => {
          if (child.isMesh) {
            child.material = new THREE.MeshStandardMaterial({
              map: baseColor,
              normalMap: normalMap,
            });

            if (child.material.map) {
              child.material.map.encoding = THREE.sRGBEncoding;
              child.material.map.needsUpdate = true;
            }
          }
        });

        const ambientLight = new THREE.AmbientLight(0xffffff, 0.8);
        scene.add(ambientLight);

        // Add directional light for highlights and shadows
        const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
        directionalLight.position.set(0, 10, 5);
        scene.add(directionalLight);

        // Ensure the renderer uses sRGB encoding
        renderer.outputEncoding = THREE.sRGBEncoding;

        // Traverse the model to adjust material encoding if needed
        model.traverse((node) => {
          if (node.isMesh && node.material.map) {
            node.material.map.encoding = THREE.sRGBEncoding;
          }
        });

        console.log("model", model);
        console.log("gltf", gltf);
        mixer = new THREE.AnimationMixer(model);

        // console.log("Available animations:", gltf.animations);
        const tracks = gltf.animations[0].tracks;
        // console.log("tracks:", tracks);

        // const idleClip = new THREE.AnimationClip('idleAnimation', tracks[1].times, [tracks[1]]);
        const fullClip = gltf.animations[0];

        // If the animation ranges are specified in frames, define your fps:
        const fps = 30;

        // Corgi Animation Ranges:

        // Idle 			0 - 140
        // Idle Happy 		145-245
        // Idle Focused		250-360
        // Idle Sit 		365-475
        // Idle Lay_Down 		480-600
        // Idle Sleep 		605-755

        // Bark 			760-860
        // Bite 			865-905
        // Damage 			910-935
        // Give Paw		940-1040
        // Hear Something		1045-1195
        // Scratch			1200-1290
        // Shake			1295-1375
        // Sniff			1380-1510
        // Tilt Head		1515-1635

        // Walk			1640-1660
        // Walk Turn Right		1665-1685
        // Walk Turn Left		1690-1710
        // Run			1715-1730
        // Run Turn Right		1735-1750
        // Run Turn Left		1755-1770
        // Walk Backwards		1775-1795
        // Walk In Place		1800-1820
        // Run In Place		1825-1840
        // Walk Backwards In Place	1845-1865

        // Jump Up			1870-1900
        // Air Flip		1905-1925
        // Fall			1930-1960
        // Land			1965-1990

        // Extracting the "Idle" animation, which is from frame 0 to 140
        const idleClip = THREE.AnimationUtils.subclip(fullClip, 'Idle', 0, 140, fps);
        window.idleAction = mixer.clipAction(idleClip);

        // const jumpClip = new THREE.AnimationClip('jumpAnimation', tracks[2].times, [tracks[2]]);
        const jumpClip = THREE.AnimationUtils.subclip(fullClip, 'Jump', 1870, 1950, fps);
        window.jumpAction = mixer.clipAction(jumpClip);
        const airflipClip = THREE.AnimationUtils.subclip(fullClip, 'Airflip', 1905, 1925, fps);
        window.airflipAction = mixer.clipAction(airflipClip);
        const fallClip = THREE.AnimationUtils.subclip(fullClip, 'Fall', 1930, 1960, fps);
        window.fallAction = mixer.clipAction(fallClip);

        const runClip = THREE.AnimationUtils.subclip(fullClip, 'Run', 1715, 1730, fps);
        window.runAction = mixer.clipAction(runClip);

        const sniffClip = THREE.AnimationUtils.subclip(fullClip, 'Sniff', 1380, 1510, fps);
        window.sniffAction = mixer.clipAction(sniffClip);

        const barkClip = THREE.AnimationUtils.subclip(fullClip, 'Bark', 760, 830, fps);
        window.barkAction = mixer.clipAction(barkClip);

        const walkClip = THREE.AnimationUtils.subclip(fullClip, 'Walk', 1800, 1820, fps);
        window.walkAction = mixer.clipAction(walkClip);

        const givepawClip = THREE.AnimationUtils.subclip(fullClip, 'GivePaw', 940, 1040, fps);
        window.givepawAction = mixer.clipAction(givepawClip);


        // window.idleAction = mixer.clipAction(tracks[1]);
        // window.jumpAction = mixer.clipAction(tracks[2]);
        // window.runAction  = mixer.clipAction(tracks[3]);
        // window.walkAction = mixer.clipAction(tracks[4]);

        window.currentAction = window.idleAction;
        window.currentAction.play();

        window.animateModelComeAndBark = () => {
          window.moveTo(1);

          const barkBark = () => {
            window.animateModelBark();

            setTimeout(() => { window.moveTo(2); }, 5000);
          }

          setTimeout(barkBark, 1000);
        }

        window.animateModelSayBye = () => {
          window.moveTo(1);

          let byeByeStep = 0;

          const byeByeBye = () => {
            if (byeByeStep == 0) {
              window.animateModelSniff();
              byeByeStep += 1;
            } else if (byeByeStep == 1) {
              window.animateModelJump();
              byeByeStep += 1;
            } else if (byeByeStep == 2) {
              window.animateModelGivePaw();
              byeByeStep = 0;
            }

            setTimeout(byeByeBye, 5000);
          }

          setTimeout(byeByeBye, 1000);
        }

        window.animateModelRun = () => {
          if (window.currentAction) {
            window.currentAction.crossFadeTo(window.runAction, 1, true);
            window.currentAction.stop();
          }
          window.currentAction = window.runAction;
          window.currentAction.play();
        }
        window.animateModelIdle = () => {
          if (window.currentAction) {
            window.currentAction.crossFadeTo(window.idleAction, 1, true);
            window.currentAction.stop();
          }
          window.currentAction = window.idleAction;
          window.currentAction.play();

          if (model.position.x >= 0) {
            window.rotateModelTo(0, -30, 0);
          } else {
            window.rotateModelTo(0, 30, 0);
          }
        }
        window.animateModelJump = () => {
          if (window.currentAction) {
            window.currentAction.crossFadeTo(window.jumpAction, 0.3, true);
            window.currentAction.stop();
          }
          window.currentAction = window.jumpAction;
          window.currentAction.play();

          setTimeout(() => {
            window.animateModelIdle();
          }, 2666);
        }

        window.animateModelBark = () => {
          if (window.currentAction) {
            window.currentAction.crossFadeTo(window.barkAction, 0.3, true);
            window.currentAction.stop();
          }
          window.currentAction = window.barkAction;
          window.currentAction.play();

          setTimeout(() => {
            window.animateModelIdle();
          }, 5000);
        }

        window.animateModelSniff = () => {
          if (window.currentAction) {
            window.currentAction.crossFadeTo(window.sniffAction, 0.3, true);
            window.currentAction.stop();
          }
          window.currentAction = window.sniffAction;
          window.currentAction.play();

          setTimeout(() => {
            window.animateModelIdle();
          }, 4000);
        }
        window.animateModelGivePaw = () => {
          if (window.currentAction) {
            window.currentAction.crossFadeTo(window.givepawAction, 0.3, true);
            window.currentAction.stop();
          }
          window.currentAction = window.givepawAction;
          window.currentAction.play();

          setTimeout(() => {
            window.animateModelIdle();
          }, 4000);
        }
        window.animateModelWalk = () => {
          if (window.currentAction) {
            window.currentAction.crossFadeTo(window.walkAction, 0.25, true);
            window.currentAction.stop();
          }
          window.currentAction = window.walkAction;
          window.currentAction.play();
        }

        window.rotateModelTo(0, 135, 0);
        model.position.x = 8;
        window.moveTo(4);
        window.animateModelIdle();
        window.setSceneRotation(0, 0, 0);

        // gltf.animations; // Array<THREE.AnimationClip>
        // gltf.scene; // THREE.Group
        // gltf.scenes; // Array<THREE.Group>
        // gltf.cameras; // Array<THREE.Camera>
        // gltf.asset; // Object
      },
      (xhr) => console.log((xhr.loaded / xhr.total * 100) + '% loaded' ),
      (error) => console.log('An error happened', error)
    );

    // Function to set scene rotation
    window.setSceneRotation = (x, y, z) => {
      scene.rotation.set(
        THREE.MathUtils.degToRad(x),
        THREE.MathUtils.degToRad(y),
        THREE.MathUtils.degToRad(z)
      );
    };

    window.rotateModelTo = (x, y, z) => {
      if (!model) {
        console.log("Model not loaded yet");
        return;
      }

      model.rotation.set(
        THREE.MathUtils.degToRad(x),
        THREE.MathUtils.degToRad(y),
        THREE.MathUtils.degToRad(z)
      );
    };

    window.moveTo = (x) => {
      if (!model || !mixer) return;

      const y = -0.7;
      const z = 2;

      const positionEnd = new THREE.Vector3(x, y, z);
      const values = [
        model.position.x, model.position.y, model.position.z,
        positionEnd.x, positionEnd.y, positionEnd.z
      ];
      let distance = Math.abs(model.position.x - positionEnd.x);

      if (positionEnd.x > model.position.x) {
        window.rotateModelTo(0, 90, 0);
      } else {
        window.rotateModelTo(0, -90, 0);
      }

      if (moveAction) moveAction.stop();

      const times = [0, 1];
      const positionTrack = new THREE.VectorKeyframeTrack('.position', times, values);

      const moveClip = new THREE.AnimationClip('move', 1, [positionTrack]);
      moveAction = mixer.clipAction(moveClip);
      moveAction.setLoop(THREE.LoopOnce);
      moveAction.clampWhenFinished = true;

      // if (distance >= 2) {
      //   window.animateModelRun();
      // } else {
        window.animateModelWalk();
      // }

      moveAction.play();
      setTimeout(() => {
        window.animateModelIdle();
      }, 1000);

      // window.animateModelRun();
      // moveAction.play();
      // window.animateModelIdle();
    }

    animate();
  }
}
