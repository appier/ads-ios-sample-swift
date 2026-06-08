import AppierAds

extension APRLogger {
    nonisolated(unsafe) static let controller = APRLogger(category: "Controller")
    nonisolated(unsafe) static let delegate = APRLogger(category: "Delegate")
}
