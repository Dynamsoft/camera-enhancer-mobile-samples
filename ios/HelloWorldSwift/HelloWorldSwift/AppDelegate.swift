import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // The string "DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9" here will grant you a public trial license good for 7 days. After that, please visit: https://www.dynamsoft.com/customer/license/trialLicense?product=dce&utm_source=installer&package=ios to request for 30 days extension.
        DynamsoftCameraEnhancer.initLicense("DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9", verificationDelegate: self)
        // Override point for customization after application launch.
        return true
    }
}

