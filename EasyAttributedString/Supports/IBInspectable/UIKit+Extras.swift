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

#if os(iOS) || os(tvOS)

import UIKit

//MARK: - UILabel

extension UILabel {
	
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
			self.styledText = self.text
		}
		get {
			if let innerValue: EAStyleProtocol? = getAssociatedValue(key: IBInterfaceKeys.styleObj.rawValue, object: self) {
				return innerValue
			}
			return EAStyleManager.shared[self.styleName]
		}
	}
	
	/// Use this to render automatically the texct with the currently set style instance or styleName.
	public var styledText: String? {
		get {
			return attributedText?.string
		}
		set {
            guard let text = newValue else {
                self.attributedText = nil
                return
            }
			self.attributedText = self.style?.set(to: text, range: nil)
		}
	}
	
}

//MARK: - UITextField

extension UITextField {
	
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
			self.styledText = self.text
		}
		get {
			if let innerValue: EAStyleProtocol? = getAssociatedValue(key: IBInterfaceKeys.styleObj.rawValue, object: self) {
				return innerValue
			}
			return EAStyleManager.shared[self.styleName]
		}
	}
	
	/// Use this to render automatically the texct with the currently set style instance or styleName.
	public var styledText: String? {
		get {
			return attributedText?.string
		}
		set {
            guard let text = newValue else {
                self.attributedText = nil
                return
            }
			self.attributedText = self.style?.set(to: text, range: nil)
		}
	}
	
}

//MARK: - UITextView

extension UITextView {
	
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
			self.styledText = self.text
		}
		get {
			if let innerValue: EAStyleProtocol? = getAssociatedValue(key: IBInterfaceKeys.styleObj.rawValue, object: self) {
				return innerValue
			}
			return EAStyleManager.shared[self.styleName]
		}
	}
	
	/// Use this to render automatically the texct with the currently set style instance or styleName.
	public var styledText: String? {
		get {
			return attributedText?.string
		}
		set {
			guard let text = newValue else {
                self.attributedText = nil
                return
            }
			self.attributedText = self.style?.set(to: text, range: nil)
		}
	}
	
}

extension UIButton {
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
            self.setStyledTitle(self.title(for: []), for: [])
        }
        get {
            if let innerValue: EAStyleProtocol? = getAssociatedValue(key: IBInterfaceKeys.styleObj.rawValue, object: self) {
                return innerValue
            }
            return EAStyleManager.shared[self.styleName]
        }
    }
    
    public func setStyledTitle(_ styledTitle: String?, for state: UIControl.State) {
        guard let text = styledTitle else {
            self.setAttributedTitle(nil, for: state)
            return
        }
        let attr = self.style?.set(to: text, range: nil)
        self.setAttributedTitle(attr, for: state)
    }
    
    public func styledTitle(for state: UIControl.State) -> String? {
        return attributedTitle(for: state)?.string
    }
}

#endif
