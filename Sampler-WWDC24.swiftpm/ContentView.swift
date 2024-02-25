import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var recorder: AudioRecorder
    @EnvironmentObject var audioEngine: AudioEngine
    
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        VStack(spacing: 0) {
            if orientation.isLandscape {
                Colors.orangeButtonGradient
                    .overlay{
                        VStack(spacing: 18){
                            Image(systemName: "rectangle.portrait.rotate")
                                .font(.largeTitle)
                            Text("Please hold your iPad in Portrait orientarion")
                        }
                        .foregroundStyle(.white)
                    }
            } else {
                VStack(spacing: 0){
                    Colors.displayColor
                        .frame(height: 420)
                        .overlay {
                            DisplayView()
                        }
                        .overlay(alignment: .bottomLeading) {
                            HStack{
                                Rectangle()
                                    .frame(width: 67, height: 1)
                                    .foregroundStyle(Colors.printedOnDeviceColor)
                                Text("POCKET SAMPLER WWDC24")
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundStyle(Colors.printedOnDeviceColor)
                            }
                                .onDisplayPrint()               .padding()
                        }
                    
                    Colors.deviceColorGradient
                        .overlay{
                            KeypadView(audioPlayer: AudioPlayer(audioEngine: audioEngine, appState: appState))
                        }
                }
                .modifier(FloatingViewModifier(floatingContent: {
                    ManualView()
                }))
            }
        }
        .ignoresSafeArea(edges: .all)
        .detectOrientation($orientation)
    }
    
}
