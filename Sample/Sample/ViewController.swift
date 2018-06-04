//
//  ViewController.swift
//  Sample
//
//  Created by 李二狗 on 2018/6/4.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import EasyAttributedString

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApplySharedAttributes()
        
        self.view.backgroundColor = #colorLiteral(red:0.79, green:0.80, blue:0.67, alpha:1.00)
        
        self.label.styleName = SharedStyleName
        self.label.styledText = "Hello, <red>World</red>!"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let next = ConversationTableViewController.init(style: .plain)
        self.navigationController?.pushViewController(next, animated: true)
    }


}

