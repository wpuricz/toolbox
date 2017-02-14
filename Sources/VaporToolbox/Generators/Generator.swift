import Console

internal let defaultTemplatesDirectory = "/Users/wpuricz/Dev/vapor-apps/84007a4ceacd92b9ccc22600dfb29b4e/"
internal let defaultTemplatesURLString = "https://gist.github.com/84007a4ceacd92b9ccc22600dfb29b4e.git"

public protocol Generator {
    var console: ConsoleProtocol { get }
    init(console: ConsoleProtocol)
    func generate(arguments: [String]) throws
}
