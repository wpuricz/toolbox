import Cocoa
import VaporToolbox
import Console

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

    @IBOutlet weak var doSomethingButton: NSButton!
    @IBAction func doSomething(_ sender: AnyObject){
        let console = Terminal(arguments: [])
        let version = Version(console: console, version: "fuck yeah")
        print(doSomethingButton.bezelStyle)

        do {
            try version.run(arguments: [])
        } catch {
            print(error)
        }
    }

}


