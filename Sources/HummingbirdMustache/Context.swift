
struct HBMustacheContext: HBMustacheMethods {
    var first: Bool
    var last: Bool
    var index: Int
    
    init(first: Bool = false, last: Bool = false) {
        self.first = first
        self.last = last
        self.index = 0
    }

    func runMethod(_ name: String) -> Any? {
        switch name {
        case "first":
            return self.first
        case "last":
            return self.last
        case "index":
            return self.index
        case "even":
            return (self.index & 1) == 0
        case "odd":
            return (self.index & 1) == 1
        default:
            return nil
        }
    }

}
