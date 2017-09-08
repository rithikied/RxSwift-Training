import Foundation

public func challenge(of description: String, action: () -> Void) {
    print("\n--- Challenge of:", description, "---\n")
    action()
}
