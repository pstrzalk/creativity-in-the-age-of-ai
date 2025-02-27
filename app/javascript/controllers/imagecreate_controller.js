import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('let us selfie');

    const initSelfie = () => {
      const videoElement = document.querySelector('.selfie-video');
      const photo = document.querySelector('.selfie-photo');
      const startbutton = document.querySelector('.selfie-startbutton');
      const canvas = document.createElement('canvas');
      const videoSelect = document.querySelector('select#videoSource');

      let debounce = false;
      let width = 800;    // We will scale the photo width to this
      let height = 0;
      let streaming = false;

      const getDevices = () => {
        // AFAICT in Safari this only gets default devices until gUM is called :/
        return navigator.mediaDevices.enumerateDevices();
      }

      const gotDevices = (deviceInfos) => {
        window.deviceInfos = deviceInfos; // make available to console
        for (const deviceInfo of deviceInfos) {
          const option = document.createElement('option');
          option.value = deviceInfo.deviceId;

          if (deviceInfo.kind === 'videoinput') {
            option.text = deviceInfo.label || `Camera ${videoSelect.length + 1}`;
            videoSelect.appendChild(option);
          }
        }
      }

      const getStream = () => {
        if (window.stream) {
          window.stream.getTracks().forEach(track => {
            track.stop();
          });
        }
        const videoSource = videoSelect.value;
        const constraints = {
          audio: false,
          video: {deviceId: videoSource ? {exact: videoSource} : undefined}
        };
        return navigator.mediaDevices.getUserMedia(constraints).
          then(gotStream).catch(handleError);
      }

      const gotStream = (stream) => {
        window.stream = stream; // make stream available to console
        videoSelect.selectedIndex = [...videoSelect.options].
          findIndex(option => option.text === stream.getVideoTracks()[0].label);
        videoElement.srcObject = stream;

        videoElement.play();

        videoElement.addEventListener('canplay', function(ev){
          if (!streaming) {
            height = videoElement.videoHeight / (videoElement.videoWidth/width);
            videoElement.setAttribute('width', width);

            videoElement.setAttribute('height', height);
            canvas.setAttribute('width', width);
            canvas.setAttribute('height', height);

            streaming = true;
          }
        }, false);

        startbutton.addEventListener('click', (event) => {
          event.preventDefault();

          if (debounce) {
            return;
          }
          debounce = true;

          setTimeout(() => { debounce = false }, 1000);
          takePicture();
        });
      }

      const handleError = (error) => {
        console.error('Error: ', error);
      }

      const takePicture = async () => {
        console.log('takePicture');
        var context = canvas.getContext('2d');
        canvas.width = width;
        canvas.height = height;
        context.drawImage(videoElement, 0, 0, width, height);
        let data = await new Promise((resolve) => {
          canvas.toBlob(resolve, 'image/webp');
        });

        const formData = new FormData();
        formData.append('image[file]', data, 'selfie.webp');
        videoElement.pause();

        const selfieContainer = document.querySelector('.selfie-container');
        let loadingMask;
        if (selfieContainer) {
          loadingMask = selfieContainer.querySelector('.loading-mask');

          if (loadingMask) {
            loadingMask.classList.remove('hidden');
          }
        }

        fetch("/images", {
          method: "POST",
          body: formData,
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
          }
        })
          .then(response => {
            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }
          })
          .then(data => {
            console.log('Upload successful:', data);
            videoElement.play();

            if (loadingMask) {
              loadingMask.classList.add('hidden');
            }
          })
          .catch(error => {
            console.error('Upload failed:', error);
          });
      }

      videoSelect.onchange = getStream;

      getStream().then(getDevices).then(gotDevices);
    }

    initSelfie();
  }
}
