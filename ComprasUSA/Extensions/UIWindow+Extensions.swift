
import UIKit

public extension UIWindow {
    static func getSafeAreaInsets() -> UIEdgeInsets {
        guard let windows = UIApplication.shared.windows.first else {
            return .zero
        }
        return windows.safeAreaInsets
    }
}
