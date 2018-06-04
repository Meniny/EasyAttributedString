//
//  ConversationTableViewCell.swift
//  Sample
//
//  Created by 李二狗 on 2018/6/4.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import EasyAttributedString

class ConversationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbale: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static var titleLabelStyle: EAStyleGroup = {
        let normal = EAStyle.init({ (s) -> (Void) in
            s.font = EASystemFonts.AmericanTypewriter_Bold.font(size: 20)
            s.color = #colorLiteral(red:0.20, green:0.21, blue:0.24, alpha:1.00)
        })
        let red = normal.byAdding {
            $0.color = #colorLiteral(red:0.80, green:0.20, blue:0.20, alpha:1.00)
            $0.traitVariants = [
                EAStringTraitVariant.bold,
                EAStringTraitVariant.tightLineSpacing
            ]
        }
        return EAStyleGroup(base: normal, ["red": red])
    }()
    
    static var subtitleLabelStyle: EAStyleGroup = {
        let subnormal = EAStyle.init({ (s) -> (Void) in
            s.font = EASystemFonts.AppleSDGothicNeo_Light.font(size: 15)
            s.color = #colorLiteral(red:0.63, green:0.63, blue:0.75, alpha:1.00)
        })
        
        let blue = subnormal.byAdding { (s) -> (Void) in
            s.color = #colorLiteral(red:0.22, green:0.80, blue:0.99, alpha:1.00)
        }
        return EAStyleGroup(base: subnormal, ["blue": blue])
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLbale.style = type(of: self).titleLabelStyle
        subtitleLabel.style = type(of: self).subtitleLabelStyle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
