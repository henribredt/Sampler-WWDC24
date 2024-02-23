import SwiftUI

@main
struct SamplerApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var recoder = AudioRecorder()
    @StateObject var audioEngine = AudioEngine()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(recoder)
                .environmentObject(audioEngine)
        }
    }
}
