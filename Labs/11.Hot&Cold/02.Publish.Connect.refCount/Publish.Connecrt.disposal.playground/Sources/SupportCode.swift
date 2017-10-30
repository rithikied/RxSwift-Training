import Foundation
import RxSwift

public enum MyError: Error {
    case anError
}

public func printEvent<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event
    )
}

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---\n")
    action()
}

