import Foundation
import SwiftUI

struct ContentView: View {
    @State private var showWelcome = true
    
    var body: some View {
        VStack {
            if showWelcome {
                WelcomeView(showWelcome: $showWelcome)
                    .onDisappear {
                        showWelcome = false
                        UserDefaults.standard.set(true, forKey: "hasSeenWelcome")
                    }
            } else {
                MainView()
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: "hasSeenWelcome") {
                showWelcome = false
            }
        }
    }
}

#Preview {
    ContentView()
}
