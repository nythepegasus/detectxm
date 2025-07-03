import Foundation

extension FileManager {
    func filePath(atPath path: String, withLength length: Int) -> String? {
        guard let file = try? contentsOfDirectory(atPath: path).filter({ $0.count == length }).first else { return nil }
        return "\(path)/\(file)"
    }
}

public extension ProcessInfo {
    var hasTXM: Bool {
#if !canImport(Darwin)
        // people have no reason to use this package on non-Apple platforms
        // however we can at least return a value for those that do (for whatever reason)
        false
#else
#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) // TODO: verify all of these follow iOS
        guard let file = FileManager.default.filePath(atPath: "/private/preboot", withLength: 96) else { return false }
#elseif os(macOS)
        // macOS varies on base paths slightly
        guard let boot = FileManager.default.filePath(atPath: "/System/Volumes/Preboot", withLength: 36),
              let file = FileManager.default.filePath(atPath: "\(boot)/boot", withLength: 96) else { return false }
#endif
        // if this file exists, we presume TXM is supported by the current hardware
        return access("\(file)/usr/standalone/firmware/FUD/Ap,TrustedExecutionMonitor.img4", F_OK) == 0
#endif
    }
}

