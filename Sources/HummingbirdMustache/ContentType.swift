/// Protocol for content types
public protocol HBMustacheContentType {
    /// escape text for this content type eg for HTML replace "<" with "&lt;"
    func escapeText(_ text: String) -> String
}

/// Text content type where no character is escaped
struct HBTextContentType: HBMustacheContentType {
    func escapeText(_ text: String) -> String {
        return text
    }
}

/// HTML content where text is escaped for HTML output
struct HBHTMLContentType: HBMustacheContentType {
    func escapeText(_ text: String) -> String {
        return text.htmlEscape()
    }
}

/// Map of strings to content types.
///
/// The string is read from the "CONTENT_TYPE" pragma `{{% CONTENT_TYPE: type}}`. Replace type with
/// the content type required. The default available types are `TEXT` and `HTML`. You can register your own
/// with `HBMustacheContentTypes.register`.
public struct HBMustacheContentTypes {
    static func get(_ name: String) -> HBMustacheContentType? {
        return types[name]
    }
    
    /// Register new content type
    /// - Parameters:
    ///   - contentType: Content type
    ///   - name: String to identify it
    public static func register(_ contentType: HBMustacheContentType, named name: String) {
        types[name] = contentType
    }
    
    static var types: [String: HBMustacheContentType] = [
        "HTML": HBHTMLContentType(),
        "TEXT": HBTextContentType()
    ]
}
