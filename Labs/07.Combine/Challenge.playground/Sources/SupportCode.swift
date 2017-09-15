import RxSwift

public enum MyError: Error {
    case anError
}

public func printEvent<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

public func challenge(of description: String, action: () -> Void) {
    print("\n--- Challenge of:", description, "---\n")
    action()
}
