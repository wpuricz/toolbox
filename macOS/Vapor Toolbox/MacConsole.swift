import Console

final class MacConsole: ConsoleProtocol {
    private let _terminal: Terminal
    public let workDir: String

    init(workDir: String, arguments: [String]) {
        self.workDir = workDir
        _terminal = Terminal(arguments: arguments)
    }

    func output(_ string: String, style: ConsoleStyle, newLine: Bool) {
        _terminal.output(string, style: style, newLine: newLine)
    }

    func input() -> String {
        return _terminal.input()
    }

    func clear(_ clear: ConsoleClear) {
        _terminal.clear(clear)
    }

    func execute(_ command: String, input: Int32?, output: Int32?, error: Int32?) throws {
        let command = "cd \(workDir); \(command)"
        try _terminal.execute(command, input: input, output: output, error: error)
    }

    var confirmOverride: Bool? {
        return _terminal.confirmOverride
    }

    var size: (width: Int, height: Int) {
        return _terminal.size
    }
}
