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

//MARK: - EAFontConvertible Protocol

/// EAFontConvertible Protocol; you can implement conformance to any object.
/// By defailt both `String` and `UIFont`/`NSFont` are conform to this protocol.
public protocol EAFontConvertible {
	/// Transform the instance of the object to a valid `UIFont`/`NSFont` instance.
	///
	/// - Parameter size: optional size of the font.
	/// - Returns: valid font instance.
	func font(size: CGFloat?) -> EAFont
}


// MARK: - EAFontConvertible for UIFont/NSFont
extension EAFont: EAFontConvertible {
	
	/// Return the same instance of the font with specified size.
	///
	/// - Parameter size: size of the font in points. If size is `nil`, `EAFont.systemFontSize` is used.
	/// - Returns: instance of the font.
	public func font(size: CGFloat?) -> EAFont {
		#if os(tvOS)
		return EAFont(name: self.fontName, size: (size ?? TVOS_SYSTEMFONT_SIZE))!
		#elseif os(watchOS)
		return EAFont(name: self.fontName, size: (size ?? WATCHOS_SYSTEMFONT_SIZE))!
		#else
		return EAFont(name: self.fontName, size: (size ?? EAFont.systemFontSize))!
		#endif
	}
	
}

// MARK: - EAFontConvertible for String
extension String: EAFontConvertible {
	
	/// Transform a string to a valid `UIFont`/`NSFont` instance.
	/// String must contain a valid Postscript font's name.
	///
	/// - Parameter size: size of the font.
	/// - Returns: instance of the font.
	public func font(size: CGFloat?) -> EAFont {
		#if os(tvOS)
		return EAFont(name: self, size:  (size ?? TVOS_SYSTEMFONT_SIZE))!
		#elseif os(watchOS)
		return EAFont(name: self, size:  (size ?? WATCHOS_SYSTEMFONT_SIZE))!
		#else
		return EAFont(name: self, size: (size ?? EAFont.systemFontSize))!
		#endif
	}
	
}
