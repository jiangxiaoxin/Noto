//
//  AppDelegate.swift
//  TipTyper
//
//  Created by Bruno Philipe on 14/1/17.
//  Copyright © 2017 Bruno Philipe. All rights reserved.
//

import Cocoa
import CCNPreferencesWindowController

let kTipTyperErrorDomain = "com.brunophilipe.TipTyper"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
	let preferencesController = CCNPreferencesWindowController()

	var keyDocumentCanReopen: NSNumber
	{
		return NSNumber.init(value: NSDocumentController.shared().currentDocument?.fileURL != nil)
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification)
	{
		// Insert code here to initialize your application
		makePreferencesController()
	}

	func applicationWillTerminate(_ aNotification: Notification)
	{
		// Insert code here to tear down your application
	}
	
	private func makePreferencesController()
	{
		preferencesController.centerToolbarItems = true
		
		let types: [PreferencesController.Type] = [
			EditorPreferencesViewController.self,
			ThemePreferencesController.self
		]

		if let window = preferencesController.window
		{
			let controllers: [PreferencesController] = types.reduce([])
			{
				(controllers, controllerType) -> [PreferencesController] in

				if let controller = controllerType.make(preferencesWindow: window)
				{
					return controllers + [controller]
				}
				else
				{
					return controllers
				}
			}

			preferencesController.setPreferencesViewControllers(controllers)
		}
		
		
	}
}

extension AppDelegate
{
	@IBAction func showPreferences(_ sender: AnyObject)
	{
		preferencesController.showPreferencesWindow()
	}
}
