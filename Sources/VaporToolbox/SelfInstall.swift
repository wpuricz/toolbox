import Console

public final class SelfInstall: Command {
    public let id = "install"

    public let signature: [Argument] = [
        Option(name: "path"),
    ]

    public let help: [String] = [
        "Moves the compiled toolbox to a folder.",
        "Installations default to /usr/local/bin/vapor."
    ]

    public let console: ConsoleProtocol
    public let executable: String
    let version: String

    public init(console: ConsoleProtocol, executable: String, version: String) {
        self.console = console
        self.executable = executable
        self.version = version
    }

    public func run(arguments: [String]) throws {
        let file: String
        do {
            file = try console.backgroundExecute("ls \(executable)")
        } catch ConsoleError.subexecute(_) {
            do {
                file = try console.backgroundExecute("which \(executable)")
            } catch ConsoleError.subexecute(_) {
                throw ToolboxError.general("Could not locate executable.")
            }
        }

        let current = file.trim()

        let command = "mv \(current) /usr/local/bin/vapor"
        do {
            _ = try console.backgroundExecute(command)
        } catch ConsoleError.subexecute(_) {
            console.warning("Install failed, trying sudo")
            do {
                _ = try console.backgroundExecute("sudo \(command)")
            } catch ConsoleError.subexecute(_) {
                throw ToolboxError.general("Installation failed.")
            }
        }

        console.success("Vapor Toolbox v\(version) Installed")
    }
}
