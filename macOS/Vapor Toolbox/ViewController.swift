import Cocoa
import VaporToolbox
import Console
import Core
import Foundation

class ViewController: NSViewController {
    var console: ConsoleProtocol!
    var queue: OperationQueue!

    @IBOutlet weak var directoryField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        console = MacConsole(workDir: "", arguments: ["-y"])
        queue = OperationQueue()
    }

    @IBAction func syncButtonPressed(_ sender: AnyObject) {
        let dir = directoryField.stringValue
        console = MacConsole(workDir: dir, arguments: ["-y"])

        let version = Version(console: console, version: "1.0")
        queue.addOperation {
            do {
                let v = try version.frameworkVersion(arguments: [])
                self.versionLabel.stringValue = v
            } catch {
                self.versionLabel.stringValue = "Error: \(error)"

            }
        }
    }


    @IBOutlet weak var xcodeLabel: NSTextField!
    @IBAction func generateXcodeButtonPressed(_ sender: AnyObject) {
        let fetch = Fetch(console: console)
        let xcode = Xcode(console: console)

        xcodeLabel.stringValue = "Fetching..."
        queue.addOperation {
            do {
                try fetch.run(arguments: [])
                self.xcodeLabel.stringValue = "Generating..."
                try xcode.run(arguments: [])
                self.xcodeLabel.stringValue = "Done"
            } catch {
                self.xcodeLabel.stringValue = "Error: \(error)"
            }
        }
    }

    @IBOutlet weak var runButton: NSButton!
    @IBOutlet weak var portField: NSTextField!
    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet weak var runLabel: NSTextField!
    @IBAction func runButtonPressed(_ sender: AnyObject) {
        let build = Build(console: console)
        let fetch = Fetch(console: console)
        let run = Run(console: console)

        let port = portField.stringValue != "" ? portField.stringValue : "8080"

        if runButton.title == "Stop" {
            self.runButton.title = "Run"
            queue.cancelAllOperations()
        } else {
            self.runButton.title = "Stop"
            queue.addOperation {
                do {
                    self.runLabel.stringValue = "Fetching..."
                    try fetch.run(arguments: [])
                    self.runLabel.stringValue = "Building..."
                    try build.run(arguments: [])
                    self.runLabel.stringValue = "Running..."
                    try run.run(arguments: ["serve", "--config:servers.default.port=\(port)"])
                } catch {
                    self.runLabel.stringValue = "Error: \(error)"
                }
            }
        }
    }
}

