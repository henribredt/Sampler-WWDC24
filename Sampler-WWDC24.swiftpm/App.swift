import SwiftUI

@main
struct SamplerApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var recoder = AudioRecorder()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(recoder)
        }
    }
}
