import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var recorder: AudioRecorder
    
    var body: some View {
        VStack(spacing: 0) {
            Colors.displayColor
                .frame(height: 360)
                .overlay {
                }
            
            Colors.deviceColorGradient
                .overlay{
                   KeypadView()
                }
        }
        .ignoresSafeArea(edges: .all)
    }
    
}
