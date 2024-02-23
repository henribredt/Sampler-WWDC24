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
                        .frame(height: 360)
                        .overlay {
                        }
                    
                    Colors.deviceColorGradient
                        .overlay{
                            KeypadView(audioPlayer: MultiAudioPlayer(audioEngine: audioEngine))
                        }
                }
                
            }
        }
        .ignoresSafeArea(edges: .all)
        .detectOrientation($orientation)
    }
    
}
