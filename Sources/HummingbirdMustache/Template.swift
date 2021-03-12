
enum HBMustacheError: Error {
    case sectionCloseNameIncorrect
    case unfinishedSectionName
    case expectedSectionEnd
}

public class HBMustacheTemplate {
    public init(string: String) throws {
        self.tokens = try Self.parse(string)
    }

    internal init(_ tokens: [Token]) {
        self.tokens = tokens
    }
    
    enum Token {
        case text(String)
        case variable(String)
        case unescapedVariable(String)
        case section(String, HBMustacheTemplate)
        case invertedSection(String, HBMustacheTemplate)
    }

    let tokens: [Token]
}

