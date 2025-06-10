import SwiftUI

@main
struct MySwiftUIAppApp: App {
    // AppDelegate support
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
