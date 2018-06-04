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

extension NSNumber {
	
	internal static func from(float: Float?) -> NSNumber? {
		guard let float = float else { return nil }
		return NSNumber(value: float)
	}
	
	internal static func from(int: Int?) -> NSNumber? {
		guard let int = int else { return nil }
		return NSNumber(value: int)
	}
	
	internal static func from(underlineStyle: NSUnderlineStyle?) -> NSNumber? {
		guard let v = underlineStyle?.rawValue else { return nil }
		return NSNumber(value: v)
	}
	
	internal func toUnderlineStyle() -> NSUnderlineStyle? {
		return NSUnderlineStyle.init(rawValue: self.intValue)
	}
	
}
