<h1 align="center">
<img width="100" height="100" alt="photo" src="https://github.com/user-attachments/assets/270eaa97-1493-4a0f-aa7d-b7e932803bee" />
<br> Spelarö <br>

<h4 align="center">
A standalone audio player and optical transmitter powered by the ESP32-S3. Play FLAC and MP3 files from a micro SD card, navigate your library using the 2.8-inch screen and 5-way switch, and output clean digital audio via TOSLINK.
</h4>

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Project](https://img.shields.io/badge/Project-Hardware-yellow.svg)
![Macondo](https://img.shields.io/badge/HackClub-Macondo-red.svg)


<img width="3840" height="2160" alt="front" src="https://github.com/user-attachments/assets/018472c6-5f51-4824-9b8e-4eb2aa4a17ab" />

# About the project

Spelarö is a custom hardware project that lets you play audio files directly from a micro SD card and send them optically to an amplifier, DAC, or speakers using a standard TOSLINK cable. It's built to give you a clean digital audio source without dealing with Bluetooth compression or ground loop noise.

## How It Works

* **Storage:** Music files are stored on a standard micro SD card. The ESP32-S3 reads the files directly from the card.
* **Interface:** You use a 2.8-inch TFT display to see your library and a 5-way joystick switch to navigate through folders and tracks, plus an extra button for auxiliary controls.
* **Audio Output:** The ESP32-S3 processes the audio data and sends it out through an OTJ-5 TOSLINK optical transmitter, converting the signal into light to avoid electrical interference.
* **Status LED:** An onboard NeoPixel (WS2812B) provides visual feedback for power and playback status.

## Features

* **ESP32-S3-NANO** microcontroller
* **1x 2.8" TFT Display** 
* **1x 5-way tactile joystick switch** 
* **1x 1-way tactile switch** 
* **1x Micro SD Card Reader** 
* **1x Neopixel WS2812B** 
* **1x Optical Toslink Transmitter (OTJ-5)** 

# Schematic
<img width="1242" height="882" alt="Screenshot 2026-08-01 004133" src="https://github.com/user-attachments/assets/1c50a60f-3ade-4680-b8df-a4bd8780b275" />

# PCB
<img width="480" height="400" alt="image" src="https://github.com/user-attachments/assets/dceab73c-c0d2-470e-af67-ba29eb166972" />
<img width="480" height="400" alt="image" src="https://github.com/user-attachments/assets/cc2b7b77-dfa9-4b15-a29c-6a73f544e3a2" />

# Bill Of Materials

| Designator | Footprint | Qty | Value | Link | Price (USD) |
| :--- | :--- | :---: | :--- | :--- | :---: |
| A1 | `MODULE_NANO-ESP32-ENTRY` | 1 | Arduino_Nano_ESP32 | [Electrokit](https://www.electrokit.com/utvecklingskort-esp32-s3-nano-kompatibelt) | $16.72 |
| C1 | `1206` | 1 | 100nF | [Electrokit](https://www.electrokit.com/kondensator-1206-x7r-100nf-10) | $1.05 |
| J1 | `PinHeader_1x14_P2.54mm_Vertical` | 1 | Conn_01x14_Pin | [Amazon](https://www.amazon.se/gp/product/B09Z29CGY1/ref=ox_sc_act_image_1?smid=A3LA1TDA4Q3SUA&psc=1) | $13.67 |
| LED1 | `WS2812B` | 1 | WS2812B | [Electrokit](https://www.electrokit.com/led-smd5050-rgb-adresserbar-sk6812) | $1.31 |
| R1, R2, R3 | `1206` | 3 | 10k | [Electrokit](https://www.electrokit.com/motstand-10kohm-0.25w-smd-1206) | $1.05 |
| S1 | `SW_VS-1213-67-160GF` | 1 | VS-1213-67-160GF | [Electrokit](https://www.electrokit.com/tryckknapp-pcb-12x12x5mm) | $1.35 |
| SW1 | `C145910` | 1 | K1-1506SN-01 | [Electrokit](https://www.electrokit.com/joystick-navigationsknapp-5-vags-smd-10x10mm-1) | $1.95 |
| TF1 | `TF-SMD_TF-012` | 1 | TF-CARD H1.8 SY | [Electrokit](https://www.electrokit.com/kontakt-microsd) | $1.37 |
| U3 | `toslink` | 1 | OTJ-5 | [Electrokit](https://www.electrokit.com/toslink-optisk-sandare-pcb) | $2.94 |
| PCB | - | 5 | - | [JLCPCB](https://jlcpcb.com/) | $2.10 |
| **Shipping** | - | - | - | - | $33.01 |
| **Total** | - | - | - | - | **$76.52** |
