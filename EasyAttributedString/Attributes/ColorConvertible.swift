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

// MARK: - EAColorConvertible

/// `EAColorConvertible` protocol conformance is used to pass your own instance of a color representable object
/// as color's attributes for several properties inside a style. EAStyle get the color instance from your object
/// and use it inside for string attributes.
/// Both `String` and `UIColor`/`NSColor` already conforms this protocol.
public protocol EAColorConvertible {
	/// Transform a instance of a `EAColorConvertible` conform object to a valid `UIColor`/`NSColor`.
	var color: EAColor { get }
}

// MARK: - EAColorConvertible for `UIColor`/`NSColor`

extension EAColor: EAColorConvertible {
	
	/// Just return itself
	public var color: EAColor {
		return self
	}
	
	/// Initialize a new color from HEX string representation.
	///
	/// - Parameter hexString: hex string
	public convenience init(hexString: String) {
		let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
		let scanner   = Scanner(string: hexString)
		
		if hexString.hasPrefix("#") {
			scanner.scanLocation = 1
		}
		
		var color: UInt32 = 0
		
		if scanner.scanHexInt32(&color) {
			self.init(hex: color, useAlpha: hexString.count > 7)
		} else {
			self.init(hex: 0x000000)
		}
	}
	
	/// Initialize a new color from HEX string as UInt32 with optional alpha chanell.
	///
	/// - Parameters:
	///   - hex: hex value
	///   - alphaChannel: `true` to include alpha channel, `false` to make it opaque.
	public convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
		let mask = UInt32(0xFF)
		
		let r = hex >> (alphaChannel ? 24 : 16) & mask
		let g = hex >> (alphaChannel ? 16 : 8) & mask
		let b = hex >> (alphaChannel ? 8 : 0) & mask
		let a = alphaChannel ? hex & mask : 255
		
		let red   = CGFloat(r) / 255
		let green = CGFloat(g) / 255
		let blue  = CGFloat(b) / 255
		let alpha = CGFloat(a) / 255
		
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
	
}

// MARK: - EAColorConvertible for `String`

extension String: EAColorConvertible {
	
	/// Transform a string to a color. String must be a valid HEX representation of the color.
	public var color: EAColor {
		return EAColor(hexString: self)
	}
	
}

