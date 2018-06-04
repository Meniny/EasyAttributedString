//
//  Shared.swift
//  Sample
//
//  Created by 李二狗 on 2018/6/4.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif
import EasyAttributedString

public let SharedStyleName = "SharedStyle"

public var SharedStyleGroup: EAStyleGroup = {
    let bold = EAStyle {
        #if os(macOS)
        $0.font = EAFont.boldSystemFont(ofSize: 20)
        #else
        $0.font = EASystemFonts.Helvetica_Bold.font(size: 20)
        #endif
    }
    let normal = EAStyle {
        #if os(macOS)
        $0.font = EAFont.systemFont(ofSize: 15)
        #else
        $0.font = EASystemFonts.Helvetica_Light.font(size: 15)
        #endif
    }
    let red = normal.byAdding {
        $0.color = #colorLiteral(red:0.80, green:0.20, blue:0.20, alpha:1.00)
        $0.traitVariants = [
            EAStringTraitVariant.bold,
            EAStringTraitVariant.tightLineSpacing
        ]
    }
    
    return EAStyleGroup(base: normal, ["bold" : bold, "red" : red])
}()

public func ApplySharedAttributes() {
    EAStyleManager.shared.register(SharedStyleName, style: SharedStyleGroup)
}
