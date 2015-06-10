//
//  ViewController.swift
//  Calorie Compare
//
//  Created by Christopher Seidl on 10/06/2015.
//  Copyright © 2015 Christopher Seidl. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
	
	let session         : AVCaptureSession = AVCaptureSession()
 
	var previewLayer    : AVCaptureVideoPreviewLayer!
 
	var highlightView   : UIView = UIView()
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Allow the view to resize freely
		self.highlightView.autoresizingMask =   [UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin]
		
		
		// Select the color you want for the completed scan reticle
		self.highlightView.layer.borderColor = UIColor.greenColor().CGColor
		
		self.highlightView.layer.borderWidth = 3
		
		// Add it to our controller’s view as a subview.
		self.view.addSubview(self.highlightView)
		
		// For the sake of discussion this is the camera
		let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
		// Create a nilable NSError to hand off to the next method.
		// Make sure to use the “var” keyword and not “let”
		var error : NSError? = nil
		
		let input : AVCaptureDeviceInput? = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as? AVCaptureDeviceInput
		
		// If our input is not nil then add it to the session, otherwise we’re kind of done!
		if input != nil {
			session.addInput(input)
		}
		else {
			// This is fine for a demo, do something real with this in your app. :)
			print(error)
		}
		
		let output = AVCaptureMetadataOutput()
		output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
		session.addOutput(output)
		output.metadataObjectTypes = output.availableMetadataObjectTypes
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

