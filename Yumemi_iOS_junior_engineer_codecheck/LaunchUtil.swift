//https://thwork.net/2021/11/29/swift_app_launch/

import SwiftUI

enum LaunchStatus {
    case FirstLaunch
    case NewVersionLaunch
    case Launched
}

class LaunchUtil {
    static let launchedVersionKey = "launchedVersion"
    @AppStorage(launchedVersionKey) static var launchedVersion = ""
    
    static var launchStatus: LaunchStatus {
        get{
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            let launchedVersion = self.launchedVersion
            
            self.launchedVersion = version
            
            if launchedVersion == "" {
                return .FirstLaunch
            }
            
            return version == launchedVersion ? .Launched : .NewVersionLaunch
        }
    }
}
