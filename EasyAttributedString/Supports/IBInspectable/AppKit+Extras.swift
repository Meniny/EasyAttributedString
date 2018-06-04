//
//  EasyAttributedString
//
//  Created by Elias Abel
//  Copyright © 2018 Meniny Lab. All rights reserved.
//
//  Blog: https://meniny.cn
//  Email: admin@meniny.cn
//  Twitter: @_Meniny
//

import Foundation

#if os(OSX)
import AppKit

//MARK: - NSTextField

extension NSControl {
    /// The name of a style in the global `NamedStyles` registry.
    @IBInspectable
    public var styleName: String? {
        get { return getAssociatedValue(key: IBInterfaceKeys.styleName.rawValue, object: self) }
        set {
            set(associatedValue: newValue, key: IBInterfaceKeys.styleName.rawValue, object: self)
            self.style = EAStyleManager.shared[newValue]
        }
    }
    
    /// EAStyle instance to apply. Any change of this value reload the current text of the control with set style.
    public var style: EAStyleProtocol? {
        set {
            set(associatedValue: newValue, key: IBInterfaceKeys.styleObj.rawValue, object: self)
            self.styledText = self.stringValue
        }
        get {
            if let innerValue: EAStyleProtocol? = getAssociatedValue(key: IBInterfaceKeys.styleObj.rawValue, object: self) {
                return innerValue
            }
            return EAStyleManager.shared[self.styleName]
        }
    }
    
    /// Use this to render automatically the texct with the currently set style instance or styleName.
    public var styledText: String {
        get {
            return self.attributedStringValue.string
        }
        set {
            guard let s = self.style else { return }
            self.attributedStringValue = s.set(to: newValue, range: nil)
        }
    }
}
#endif
