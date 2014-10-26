//
//  AppDelegate.swift
//  MenubarApplicationTest
//
//  Created by pascal on 26.10.14.
//  Copyright (c) 2014 pixelskull. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon:NSImage = NSImage(named:"statusIcon")!
        icon.setTemplate(true)

        statusItem.image = icon
        statusItem.menu = statusMenu
    }

    @IBAction func menuClicked(sender: NSMenuItem) {
        let task = NSTask()
        task.launchPath = "/usr/bin/defaults"

        if sender.state == NSOnState {
            sender.state = NSOffState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "No"]
        } else {
            sender.state = NSOnState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
        }

        task.launch()
        task.waitUntilExit()

        let killTask = NSTask()
        killTask.launchPath = "/usr/bin/killall"
        killTask.arguments = ["Finder"]
        killTask.launch()
    }

}

