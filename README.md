# Pocket Sampler
Created as a Swift Student Challenge 2024 Submission by [Henri Bredt](https://twitter.com/henricreates) in February 2024.

![PocketSampler](https://github.com/henribredt/Sampler-WWDC24/assets/57298155/d318c774-9efc-46cf-9d56-9f1e3c14c166)


## About
My project this year is a music sampler. It allows you to create music by creatively manipulating and replaying pre-recorded sounds. That way, it provides an accessible entry point into music creation, because it eliminates the need to learn musical notation and invites people to experiment.

The concept of this app is to bring the fun and nostalgic feeling of a hardware sampler to the iPad. I’ve intentionally chosen a design that is reminiscent of a physical object—with all its limitations. Fitting all features onto 16 buttons and still fostering a clear mental model was a challenge. Status LEDs, two simple modes and a retro-style info display communicate the system status.

At its core, the player is build upon AVAudioEngine. It is capable of playing up to 9 samples plus system sounds simultaneously (10 tracks in total) while applying non-destructive rich sound effects such as pitch, gain, trim and low pass filter. All effects are non-destructive. The app saves data that describes the edits a user has made to disk and applies them in real time once a sample plays. That way, it’s possible to keep the original audio file so that the user can revert the edits.

## Installation
Clone this repository and open the **.swiftpm** with the Swift Playgrounds app on your iPad.

## Credtis
- Button Sounds: https://snd.dev/# SND01 "sine" by Yasuhiro Tsuchiya (Free for Personal and Commercial use)
- Samples made in GarageBand
- UI Design inspiration: Teenage Engineering EP-133 K.O. II and Teenage Engineering OP-1 field
