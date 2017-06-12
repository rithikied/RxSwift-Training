//: Playground - noun: a place where people can play

protocol ObserverProtocol {
    func update()
}

class Observable {

    private var observers = [ObserverProtocol]()

    func attach(observer: ObserverProtocol) {
        observers.append(observer)
    }

    func notify() {
        for eachObserver in observers {
            eachObserver.update()
        }
    }
}

class ConcreteObserver1: ObserverProtocol {
    func update() {
        print("Concrete Observer 1 gets notified.")
    }
}

class ConcreteObserver2: ObserverProtocol {
    func update() {
        print("Concrete Observer 2 gets notified.")
    }
}

example(of: "Observer Pattern") { 
    let observable = Observable()
    let observer1 = ConcreteObserver1()
    let observer2 = ConcreteObserver2()

    observable.attach(observer: observer1)
    observable.attach(observer: observer2)
    observable.notify()
}
