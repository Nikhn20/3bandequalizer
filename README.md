# Lydprojektminiprojekt_UI

This MATLAB script creates a simple graphical user interface (GUI) for a three-band graphic equalizer. It allows users to adjust the gain for low, mid, and high-frequency bands of an audio file and visualize the combined frequency response.

## Features

- **Three-Band Equalizer:** Control the gain for low (20 Hz), mid (500 Hz), and high (5000 Hz) frequency bands.
- **Real-Time Visualization:** View the combined frequency response of the equalizer in real-time on a logarithmic scale.
- **Audio Playback:** Play and stop the filtered audio directly from the GUI.

## Requirements

- MATLAB
- Audio file named `SlapAf.mp3` in the same directory as the script

## Usage

1. **Run the Script:** Execute the `Lydprojektminiprojekt_UI` function in MATLAB.
2. **Adjust Gains:** Use the sliders to adjust the gain for each frequency band. The corresponding edit fields will update automatically.
3. **Play/Stop Audio:** Use the "Play sound" button to listen to the filtered audio and the "Stop sound" button to stop playback.
