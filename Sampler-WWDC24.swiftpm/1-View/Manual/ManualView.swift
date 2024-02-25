//
//  SwiftUIView.swift
//
//
//  Created by Henri Bredt on 25.02.24.
//

import SwiftUI

struct ManualView: View {
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 60, height: 4)
                .foregroundStyle(Color.gray.opacity(0.2))
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
        .frame(width: 280, height: 360)
        .padding(EdgeInsets(top: 0, leading: 4, bottom: 10, trailing: 4))
        .background{
            RoundedRectangle(cornerRadius: 12)
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
            chapter: "Chapter 1",
            title: "What's a Sampler?",
            description: "A sampler is a device that records and plays back audio samples. This can be a valuable tool for musicians to explore new compositions. Before we start, here are some hints about this app:",
            steps: [
                ManualContentStep(no: "1", text: "You can move this \"User Guide\" around to uncover the areas of the sampler you need to interact with."),
                ManualContentStep(no: "2", text: "Make sure you're device is in Portrait orientarion, the volume is turned on and to have some fun while making music :D"),
                ManualContentStep(no: "3", text: "Follow along with the \"User Guide\" or explore on your own."),
            ]),
        ManualContent(
            chapter: "Chapter 2",
            title: "Play Samples",
            description: "This Sampler has nine Sample Pads. You can spot them by their numerical label and the light gray color. Each Pad can hold a Sound Sample that playes when you tap it. PLAY mode is the default.",
            steps: [
                ManualContentStep(no: "1", text: "You can only play Samples, if you're in the PLAY mode. Check the mode by looking at the top left corner of the display."),
                ManualContentStep(no: "2", text: "The Sampler comes with some Samples preinstalled on the first seven banks. But you can also replace them with your own samples, read more in the next Chapter."),
            ]),
        ManualContent(
            chapter: "Chapter 3",
            title: "Record Samples",
            description: "The preinstalled Samples are for demo purposes. You'll unlock the real power of this sampler, once you create your own Samples by recoding with your iPads mic.",
            steps: [
                ManualContentStep(no: "1", text: "Find a Pad you want to record your new Sample to. Tap and hold the Pad until you can see that the Mode has changed to EDIT."),
                ManualContentStep(no: "2", text: "Now press the orange REC button, you'll hear a Countdown. Your recording starts after the last \"Beep\" sound."),
                ManualContentStep(no: "3", text: "Once you're done, hit REC again to stop the recording. The Mode automatically changes to PLAY mode. Now you can rap the Pad and you'll hear your new Sample."),
            ]),
        ManualContent(
            chapter: "Chapter 4",
            title: "Duplicate Samples",
            description: "You can copy and paste a Sample from one Pad to another if you wish.",
            steps: [
                ManualContentStep(no: "1", text: "Tap and hold the Pad you want to copy from to go to EDIT mode."),
                ManualContentStep(no: "2", text: "Tap and hold the Pad you want to  copy the Sample to. That's it. PLAY mode is automatically activated and you'll hear the pasted Sample."),
            ]),
        ManualContent(
            chapter: "Chapter 5",
            title: "Edit Samples",
            description: "This Sampler has four Effects (FX) build-in. They can be used to manipulate the Sound you've stored to a Pad. Gain, Pitch, a Low-Pass filter and a Trim function are available. Read more about the individual effects in the following chapters. All Effects are non-destructive and can be reset.",
            steps: [
                ManualContentStep(no: "1", text: "Tap and hold a Pad you want to apply an Effect to in order to bring it into EDIT mode."),
                ManualContentStep(no: "2", text: "Select the desired effect from  the dark-gray colored effects buttons."),
                ManualContentStep(no: "3", text: "Adjust the Effect strength with the black + and - buttons. The red triangle in the Effects Display indicates your current effect strength."),
                ManualContentStep(no: "4", text: "To reset the effect to the default effect strength, tap and hold the current dark-gray colored effect button."),
                ManualContentStep(no: "5", text: "To exit EDIT mode, tap and hold the Pad you're editing. You're then back in play mode."),
            ]),
        ManualContent(
            chapter: "Chapter 6",
            title: "Gain FX",
            description: "The Gain effect allows you to adjust the volume of a Sample. The red triangle in the Effects Display indicates your current effect strength. As the triangle moves from left to right, the volume increases. Tap + and - to adjust.",
        steps: nil
        )
    ]
}
