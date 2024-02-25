//
//  SwiftUIView.swift
//
//
//  Created by Henri Bredt on 25.02.24.
//

import SwiftUI

struct ManualView: View  {
    @State private var isCollapsed: Bool = false
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 66, height: 5)
                .foregroundStyle(Color.gray.opacity(0.2))
                .onTapGesture {
                    withAnimation {
                        isCollapsed.toggle()
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            ScrollView{
                ForEach(ManualContent.tutorial) { manualContent in
                    VStack(alignment: .leading, spacing: 4){
                        Text(manualContent.chapter)
                            .font(.caption2.weight(.bold))
                            .textCase(.uppercase)
                            .foregroundStyle(Color.gray)
                        Text(manualContent.title)
                            .fontWeight(.semibold)
                        Divider()
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 11, trailing: 0))
                        Text(manualContent.description)
                            .font(.footnote)
                            .padding(.bottom)
                        
                        if let contentSteps = manualContent.steps {
                            ForEach(contentSteps) { step in
                                HStack(alignment: .top, spacing: 12){
                                    Text(step.no)
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.white)
                                        .padding(9)
                                        .background {
                                            Circle()
                                                .foregroundStyle(Color.black)
                                        }
                                    Text(step.text)
                                        .font(.footnote)
                                }
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.bottom, 28)
                }
                .padding(.horizontal, 20)
            }
        }
        .foregroundStyle(Color.black)
        .frame(width: 280, height: !isCollapsed ? 380 : 37)
        .padding(EdgeInsets(top: 0, leading: 4, bottom: 10, trailing: 4))
        .background{
            RoundedRectangle(cornerRadius: !isCollapsed ? 12 : 10 )
                .foregroundStyle(Colors.labelColorWhite)
                .shadow(radius: 12, x:3, y: 3)
        }
    }
}

#Preview {
    ManualView()
}


struct ManualContent: Identifiable {
    let id = UUID()
    let chapter: String
    let title: String
    let description: String
    let steps: [ManualContentStep]?
    
    struct ManualContentStep: Identifiable {
        let id = UUID()
        let no: String
        let text: String
    }
}

extension ManualContent {
    static let tutorial : [ManualContent] = [
        ManualContent(
            chapter: "Welcome to",
            title: "Pocket Sampler WWDC24",
            description: "I've built this Sampler as a submission to the Swift Student Challenge 2024. At the moment, you're looking at its user manual. This is where I explain how the Sampler works and show you some tips and tricks. But before we start, here are some things to note:",
            steps: [
                ManualContentStep(no: "1", text: "Make sure to hold your iPad in portrait orientation. Ensure the device is not muted and the volume is loud enough."),
                ManualContentStep(no: "2", text: "You can drag this user manual around to uncover the areas of the sampler you want to interact with."),
                ManualContentStep(no: "3", text: "Follow along with the user manual or explore on your own. Whenever you want, you can collapse this window by tapping the top handle and slide it away."),
            ]),
        ManualContent(
            chapter: "Chapter 1",
            title: "What's a Sampler?",
            description: "A sampler is a device that records and plays back audio samples. It's often used by musicians to explore new compositions. Even for non-musicians, sampling is a straightforward method to make music. It eliminates the need to learn traditional musical notation by replaying pre-recorded sounds and manipulating them creatively instead.",
            steps: nil),
        ManualContent(
            chapter: "Chapter 2",
            title: "Play Samples",
            description: "This sampler has nine sample pads. You can recognize them by their numerical label and the light gray color. Each sample pad can hold a sound sample that plays when you tap it.",
            steps: [
                ManualContentStep(no: "1", text: "You can play samples when the device is in PLAY mode. Check the mode by looking at the top left corner of the display. PLAY mode is on by default. All sample pads can play simultaneously."),
                ManualContentStep(no: "2", text: "This sampler comes with some samples pre-loaded on the first seven pads. You can replace them with your own samples, read more in the next chapter."),
                ManualContentStep(no: "3", text: "It's your turn: Move the user manual out of the way and start playing some samples. If you could use a little guidance, see the Inspiration below — otherwise feel free to skip it."),
            ]),
        ManualContent(
            chapter: "Inspiration",
            title: "Let it Drum",
            description: "Let's learn how to play your first simple slow beat. Note: The pre-loaded samples are required.",
            steps: [
                ManualContentStep(no: "1", text: "We'll only use the first three pads. All are loaded with drum sounds."),
                ManualContentStep(no: "2", text: "Play pad 1 repeatedly with the left hand as the basic beat. Choose a low to medium repeating frequency."),
                ManualContentStep(no: "3", text: "Now play pad 2 and 3 with your right hand alternately to the beat."),
                ManualContentStep(no: "4", text: "Congrats! That's your first beat. Now you could try to play this with one hand. Then play around with other rhythms."),
            ]
        ),
        ManualContent(
            chapter: "Chapter 3",
            title: "Record Samples",
            description: "The pre-loaded samples are for demo purposes. You'll unlock the real power of this sampler, once you create your own samples by recording with your iPads mic.",
            steps: [
                ManualContentStep(no: "1", text: "Find a pad you want to record your new sample to. Tap and hold the pad until you can see that the mode has changed to EDIT."),
                ManualContentStep(no: "2", text: "Now press the orange REC button, you'll hear a countdown. Your recording starts after the last \"beep\" sound."),
                ManualContentStep(no: "3", text: "Once you're done, hit REC again to stop the recording. The mode automatically changes back to PLAY mode. Now you can play the new sample with a tap on the pad you've recorded to."),
            ]),
        ManualContent(
            chapter: "Chapter 4",
            title: "Duplicate Samples",
            description: "You can copy and paste a sample from one pad to another. This can be really powerful in combination with different effects on each copy. You'll learn about effects later. To duplicate a sample, do the following:",
            steps: [
                ManualContentStep(no: "1", text: "Tap and hold the pad you want to copy from in order to activate EDIT mode."),
                ManualContentStep(no: "2", text: "Tap and hold the pad you want to copy the sample to. That's it. PLAY mode is automatically activated and you'll hear the pasted sample playing."),
            ]),
        ManualContent(
            chapter: "Chapter 5",
            title: "Edit Samples",
            description: "This sampler has four effects (FX) built-in. They can be used to manipulate the sound you've stored to a pad. Gain, Pitch, a Low-Pass filter and a Trim tool are available. Read more about the individual effects in the following chapters. All effects are non-destructive and can be reset.",
            steps: [
                ManualContentStep(no: "1", text: "Tap and hold a pad you want to apply an effect to in order to bring it into EDIT mode."),
                ManualContentStep(no: "2", text: "Select the desired effect from the dark-gray colored effect buttons."),
                ManualContentStep(no: "3", text: "Adjust the effect strength with the black + and - buttons. The red triangle in the effects display indicates your current effect strength."),
                ManualContentStep(no: "4", text: "To reset an effect to the default effect strength, tap and hold the button of the effect you're editing."),
                ManualContentStep(no: "5", text: "To exit EDIT mode, tap and hold the pad you're editing. You're then back in PLAY mode and your edits are applied."),
            ]),
        ManualContent(
            chapter: "Chapter 6",
            title: "Gain FX",
            description: "The GAIN effect allows you to adjust the volume of a sample. The red triangle in the effects display indicates the current effect strength. As the triangle moves from left to right, the volume increases. Tap + and - to adjust.",
        steps: nil
        ),
        ManualContent(
            chapter: "Chapter 7",
            title: "Pitch FX",
            description: "With the PITCH effect, you can change the tonal pitch of a sample. Tap + and - to increase and decrease the pitch. One step represents a halftone. The red triangle in the effects display indicates the current effect strength.",
            steps: nil
        ),
        ManualContent(
            chapter: "Chapter 8",
            title: "Low Pass Filter FX",
            description: "The LOW PASS filter allows only signals with a frequency lower than a certain cutoff frequency to pass through, suppressing higher-frequency components. This helps to remove static noise from the mic or to apply a stylistic effect. You can adjust the cutoff frequency by pressing the + and - buttons. When you press +, the cutoff is decreased, hence the effect becomes stronger. The red triangle in the effects display indicates the current effect strength.",
            steps: nil
        ),
        ManualContent(
            chapter: "Chapter 9",
            title: "Trim FX",
            description: "The TRIM tool lets you cut off up to 2 seconds from the beginning of a sample. This allows you to remove unwanted silence you might have picked up while recording before the actual sound has started. Tap + to begin cutting from the start. Every time you press +, you cut 0.05s from the start of the sample. Due to its non-destructive nature, you can use - to reduce the trim value. The red triangle in the effects display indicates the current effect strength. If you set a trim value that is longer than the duration of your sample, no sound will be played.",
            steps: nil
        ),
        ManualContent(
            chapter: "Inspiration",
            title: "A Funky Beat",
            description: "Let's play a fun 80's beat. Note: The pre-loaded samples are required. If you've replaced them, delete the app data in Swift Playgrounds to restore.",
            steps: [
                ManualContentStep(no: "1", text: "Familiarize yourself with the pads. Pad 4 and 5 are your drums. Pad 6 is a synth melody and pad is 7 a short vocal."),
                ManualContentStep(no: "2", text: "Let's create a synth with two pitches. Increase the PITCH effect of pad 6 by 1. Duplicate pad 6 to pad 9. Then increase the PITCH effect of pad 9 by 2."),
                ManualContentStep(no: "3", text: "It's time to play! Here's the sequence: Play pad 4. Once finished, play pad 5 and 6 together. Once finished, pad 4 and 9. Then 5 and 6 again. Then 4 and 7. Then 3."),
                ManualContentStep(no: "4", text: "Let's practice. It takes some runs through to remember the sequence and find the right timing."),
            ]
        ),
        ManualContent(
            chapter: "Imprint",
            title: "About and Sources",
            description: "This project was created by Henri Bredt in February 2024 as a submission to the Swift Student Challenge. All pre-loaded samples were made using GarageBand. This project utilizes sounds from https://snd.dev for system sounds. The usage is granted by license, allowing free use of the sound assets for commercial and non-commercial purposes. The UI design was partially inspired by teenage engineering EP–133 K.O. II and teenage engineering OP–1 field.",
            steps: nil
        )
    ]
}
