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
#else
import UIKit
#endif

extension NSAttributedString {
    /**
     Returns an NSAttributedString object initialized with a given string and attributes.
     
     - parameter string:     The string for the new attributed string.
     - parameter attributes: The attributes for the new attributed string.
     
     - returns: The newly created NSAttributedString.
     */
    public convenience init(string: NSString, attributes: EATextAttributes) {
        self.init(string: string as String, attributes: attributes)
    }
    
    /**
     Returns an NSAttributedString object initialized with a given string and attributes.
     
     - parameter string:     The string for the new attributed string.
     - parameter attributes: The attributes for the new attributed string.
     
     - returns: The newly created NSAttributedString.
     */
    public convenience init(string: String, attributes: EATextAttributes) {
        self.init(string: string, attributes: attributes.dictionary)
    }
    
    public convenience init(image: EAImage) {
        let attachment = NSTextAttachment.init()
        attachment.image = image
        self.init(attachment: attachment)
    }
}

extension NSMutableAttributedString {
    public func append(image: EAImage) {
        append(NSAttributedString.init(image: image))
    }
    
    /**
     Sets the attributes to the specified attributes.
     
     - parameter attributes: The attributes to set.
     */
    public func setAttributes(_ attributes: EATextAttributes) {
        setAttributes(attributes, range: NSRange(mutableString))
    }
    
    /**
     Sets the attributes for the characters in the specified range to the specified attributes.
     
     - parameter attributes: The attributes to set.
     - parameter range:      The range of characters whose attributes are set.
     */
    public func setAttributes(_ attributes: EATextAttributes, range: Range<Int>) {
        setAttributes(attributes, range: NSRange(range))
    }
    
    /**
     Sets the attributes for the characters in the specified range to the specified attributes.
     
     - parameter attributes: The attributes to set.
     - parameter range:      The range of characters whose attributes are set.
     */
    public func setAttributes(_ attributes: EATextAttributes, range: NSRange) {
        setAttributes(attributes.dictionary, range: range)
    }
    
    /**
     Adds the given attributes.
     
     - parameter attributes: The attributes to add.
     */
    public func addAttributes(_ attributes: EATextAttributes) {
        addAttributes(attributes, range: NSRange(mutableString))
    }
    
    /**
     Adds the given collection of attributes to the characters in the specified range.
     
     - parameter attributes: The attributes to add.
     - parameter range:      he range of characters to which the specified attributes apply.
     */
    public func addAttributes(_ attributes: EATextAttributes, range: Range<Int>) {
        addAttributes(attributes, range: NSRange(range))
    }
    
    /**
     Adds the given collection of attributes to the characters in the specified range.
     
     - parameter attributes: The attributes to add.
     - parameter range:      he range of characters to which the specified attributes apply.
     */
    public func addAttributes(_ attributes: EATextAttributes, range: NSRange) {
        addAttributes(attributes.dictionary, range: range)
    }
}
