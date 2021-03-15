
protocol HBMustacheMethods {
    func runMethod(_ name: String) -> Any?
}

extension String: HBMustacheMethods {
    func runMethod(_ name: String) -> Any? {
        switch name {
        case "lowercased":
            return self.lowercased()
        case "uppercased":
            return self.uppercased()
        case "reversed":
            return self.reversed()
        default:
            return nil
        }
    }
}

protocol HBComparableSequence {
    func runComparableMethod(_ name: String) -> Any?
}

extension Array: HBMustacheMethods {
    func runMethod(_ name: String) -> Any? {
        switch name {
        case "reversed":
            return self.reversed()
        case "count":
            return self.count
        default:
            if let comparableSeq = self as? HBComparableSequence {
                return comparableSeq.runComparableMethod(name)
            }
            return nil
        }
    }
}

extension Array: HBComparableSequence where Element: Comparable {
    func runComparableMethod(_ name: String) -> Any? {
        switch name {
        case "sorted":
            return self.sorted()
        default:
            return nil
        }
    }
}

extension Dictionary: HBMustacheMethods {
    func runMethod(_ name: String) -> Any? {
        switch name {
        case "count":
            return self.count
        case "enumerated":
            return self.map { (key: $0.key, value: $0.value) }
        default:
            if let comparableSeq = self as? HBComparableSequence {
                return comparableSeq.runComparableMethod(name)
            }
            return nil
        }
    }
}

extension Dictionary: HBComparableSequence where Key: Comparable {
    func runComparableMethod(_ name: String) -> Any? {
        switch name {
        case "sorted":
            return self.map { (key: $0.key, value: $0.value) }.sorted { $0.key < $1.key }
        default:
            return nil
        }
    }
}

extension Int: HBMustacheMethods {
    func runMethod(_ name: String) -> Any? {
        switch name {
        case "plusone":
            return self + 1
        default:
            return nil
        }
    }
}
