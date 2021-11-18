
import Foundation

extension String {
    func getDoubleValue() -> Double {
        if let double = Double(self) {
            return double
        }
        return 0
    }
}
