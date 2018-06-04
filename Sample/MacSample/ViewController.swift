//
//  ViewController.swift
//  MacSample
//
//  Created by 李二狗 on 2018/6/4.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var label: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApplySharedAttributes()
        
        self.label.styleName = SharedStyleName
        self.label.styledText = "Hello, <red>World</red>!"
        
        // or:
//        self.label.attributedStringValue = "Hello, <red>World</red>!".set(style: SharedStyleGroup)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

