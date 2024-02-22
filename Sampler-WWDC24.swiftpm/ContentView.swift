import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    @StateObject var recorder = AudioRecorder()
    
    var body: some View {
        VStack(spacing: 0) {
            Colors.displayColor
                .frame(height: 360)
                .overlay {
                }
            
            Colors.deviceColorGradient
                .overlay{
                    HStack(spacing: 30) {
                        ButtonView(kind: .bank, onBtnLabel: "1", belowBtnLabel: "BANK", showStatusLED: true, statusLEDisOn: appState.selectedBank == .bank1, statusLEDisBlinking: false, tapAction: {
                            recorder.playRecoding(fileName: Bank.bank1.getFileName())
                        }, longPressAction: {
                            appState.toggleSelectedBank(base: .bank1)
                        })
                        
                        ButtonView(kind: .bank, onBtnLabel: "2", belowBtnLabel: "BANK", showStatusLED: true, statusLEDisOn: appState.selectedBank == .bank2, statusLEDisBlinking: false, tapAction: {
                            recorder.playRecoding(fileName: Bank.bank2.getFileName())
                        }, longPressAction: {
                            appState.toggleSelectedBank(base: .bank2)
                        })
                        
                        ButtonView(kind: .rec, onBtnLabel: "REC", belowBtnLabel: "REC", showStatusLED: true, statusLEDisOn: recorder.isRecording, statusLEDisBlinking: false, tapAction: {
                            guard let selectedBank = appState.selectedBank else {
                                return
                            }
                            
                            if recorder.isRecording {
                                recorder.audioRecorder.stop()
                                recorder.isRecording = false
                                appState.selectedBank = nil
                            } else {
                                recorder.startRecording(fileName: selectedBank.getFileName())
                                recorder.isRecording = true
                            }
                            
                        }, longPressAction: {
                            
                        })
                    }
                }
        }
        .ignoresSafeArea(edges: .all)
    }
    
}
