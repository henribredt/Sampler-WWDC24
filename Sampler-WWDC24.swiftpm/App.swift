import SwiftUI

@main
struct SamplerApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var recoder = AudioRecorder()
    @StateObject var audioEngine = AudioEngine()
    
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(recoder)
                .environmentObject(audioEngine)
                .onAppear{
                    if !hasLaunchedBefore {
                        FileSystemManager.loadDefaultSamples()
                    }
                }
        }
    }
}
