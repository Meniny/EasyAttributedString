//
//  ConversationTableViewController.swift
//  Sample
//
//  Created by 李二狗 on 2018/6/4.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import EasyAttributedString

class ConversationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let nib = UINib.init(nibName: "ConversationTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ConversationTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationTableViewCell", for: indexPath) as! ConversationTableViewCell

        cell.avatarImageView.image = #imageLiteral(resourceName: "Doggie")
        cell.titleLbale.styledText = "Hello, world! <red>[\(indexPath.row)]</red>"
        let attr = "<blue>[New Image]</blue> from Elias.".set(style: ConversationTableViewCell.subtitleLabelStyle)
        let attachment = NSTextAttachment.init()
        attachment.image = #imageLiteral(resourceName: "icon").withRenderingMode(.alwaysOriginal)
        attr.append(NSAttributedString.init(attachment: attachment))
        cell.subtitleLabel.attributedText = attr

        return cell
    }

}
