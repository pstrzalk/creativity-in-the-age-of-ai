import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  collectCsrf() {
    const csrfMeta = document.querySelector('meta[name="csrf-token"]')

    if (csrfMeta) {
      this.csrfToken = csrfMeta.content;
    } else {
      alert("No CSRF Token");
    }
  }

  sendAudio(audioBlob) {
    const formData = new FormData();
    formData.append('audio', audioBlob, 'recording.webm');

    fetch("/audios", {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": this.csrfToken
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
    })
    .then(data => {
      console.log('Upload successful:', data);
    })
    .catch(error => {
      console.error('Upload failed:', error);
    });
  }

  startRecording() {
    document.querySelector('#recordingBar').classList.remove('hidden');
    this.recording = true;

    this.mediaRecorder.start();
    recordingIndicator.classList.add('bg-red-500');
    recordingIndicator.classList.remove('bg-grey-500');
  }

  stopRecording() {
    document.querySelector('#recordingBar').classList.add('hidden');
    console.log('stopRecording', this);
    this.recording = false;

    this.mediaRecorder.stop();
    recordingIndicator.classList.remove('bg-red-500');
    recordingIndicator.classList.add('bg-grey-500');
  }

  toggleRecording(event) {
    event.preventDefault();

    if (this.recording) {
      this.stopRecording();
    } else {
      this.startRecording();
    }
  }

  finalizeRecording(event) {
    console.log("finalizeRecording", event.data);

    this.sendAudio(event.data);
  }

  connect() {
    this.recording = false;
    this.recordingIndicator = document.querySelector('#recordingIndicator');

    this.collectCsrf();

    const initRecorder = async function (self) {
      console.log('initRecorder');
      const stream = await navigator.mediaDevices.getUserMedia({
        video: false,
        audio: true,
      })

      self.mediaRecorder = new MediaRecorder(stream, { mimeType: 'audio/webm' });
      self.mediaRecorder.addEventListener('dataavailable', self.finalizeRecording.bind(self));
    }

    initRecorder(this);
  }
}
