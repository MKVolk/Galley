const audio = document.getElementById("audio");
const playPauseBtn = document.getElementById("playPause");
const stopBtn = document.getElementById("stop");
const progress = document.getElementById("progress");
const volume = document.getElementById("volume");

// Play / Pause toggle
playPauseBtn.addEventListener("click", () => {
  if (audio.paused) {
    audio.play();
    playPauseBtn.textContent = "Pause";
  } else {
    audio.pause();
    playPauseBtn.textContent = "Play";
  }
});

// Stop button
stopBtn.addEventListener("click", () => {
  audio.pause();
  audio.currentTime = 0;
  playPauseBtn.textContent = "Play";
});

// Update progress bar
audio.addEventListener("timeupdate", () => {
  if (audio.duration) {
    const percent = (audio.currentTime / audio.duration) * 100;
    progress.value = percent;
  }
});

// Seek audio
progress.addEventListener("input", () => {
  if (audio.duration) {
    audio.currentTime = (progress.value / 100) * audio.duration;
  }
});

// Volume control
volume.addEventListener("input", () => {
  audio.volume = volume.value;
});

// Reset button state when audio ends
audio.addEventListener("ended", () => {
  playPauseBtn.textContent = "Play";
  progress.value = 0;
});

