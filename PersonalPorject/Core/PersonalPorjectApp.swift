import Foundation
import IOSSecuritySuite
import SwiftUI

@main
struct PersonalPorjectApp: App {
    //    @StateObject private var setupAppTheme = SetupAppTheme()
    @UIApplicationDelegateAdaptor private var delegate : AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SetupAppTheme())
        }
    }
}

class SetupAppTheme: ObservableObject {
    @Published var isDarkMode: Bool = false
    func changeAppTheme() {
        isDarkMode = !isDarkMode
        isDarkMode == true
            ? UserDefaults.standard.set(true, forKey: "isDarkMode")
            : UserDefaults.standard.set(false, forKey: "isDarkMode")
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        let jailbreakStatus = IOSSecuritySuite.amIJailbrokenWithFailedChecks()
        let amIDebugged: Bool = IOSSecuritySuite.amIDebugged()
        let runInEmulator: Bool = IOSSecuritySuite.amIRunInEmulator()
        
        print("Status --- ** \(runInEmulator)")
        return true
    }
}
