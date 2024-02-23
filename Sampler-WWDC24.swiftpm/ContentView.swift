import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var recorder: AudioRecorder
    @EnvironmentObject var audioEngine: AudioEngine
    
    var body: some View {
        VStack(spacing: 0) {
            Colors.displayColor
                .frame(height: 360)
                .overlay {
                }
            
            Colors.deviceColorGradient
                .overlay{
                    KeypadView(audioPlayer: MultiAudioPlayer(audioEngine: audioEngine))
                }
        }
        .ignoresSafeArea(edges: .all)
    }
    
}
