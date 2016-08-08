import Cocoa
import VaporToolbox
import Console
import Core

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func testButton(_ sender: AnyObject) {
        let console = Terminal(arguments: [])
        let version = Version(console: console, version: "fuck yeah")

        do {
            try background {
                do {
                    try version.run(arguments: [])
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
}

