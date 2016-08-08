//
//  WindowController.swift
//  VaporToolbox
//
//  Created by Tanner Nelson on 8/2/16.
//
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.titleVisibility = .hidden

        let object = NSTitlebarAccessoryViewController()

        let rect = NSRect(x: 0, y: 0, width: 28, height: 10)
        let button = NSButton(frame: rect)
        button.title = "🔙"
        button.bezelStyle = NSBezelStyle.texturedRounded
        object.view = button
        object.layoutAttribute = .left
        window?.addTitlebarAccessoryViewController(object)

        let new = NSTitlebarAccessoryViewController()
        let newrect = NSRect(x: 0, y: -10, width: 28, height: 10)
        let newbutton = NSButton(frame: newrect)
        newbutton.title = "+"
        newbutton.bezelStyle = NSBezelStyle.texturedRounded
        new.view = newbutton
        new.layoutAttribute = .right
        window?.addTitlebarAccessoryViewController(new)
    }

}
