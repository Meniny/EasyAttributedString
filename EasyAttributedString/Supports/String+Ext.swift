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

//MARK: - String Extension

// The following methods are used to produce an attributed string by a plain string.
public extension String {
	
	//MARK: RENDERING FUNCTIONS
	
	/// Apply style with given name defines in global `EAStyleManager` to the receiver string.
	/// If required style is not available this function return `nil`.
	///
	/// - Parameters:
	///   - style: name of style registered in `EAStyleManager` singleton.
	///   - range: range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: rendered attributed string, `nil` if style is not registered.
	public func set(style: String, range: NSRange? = nil) -> EAString? {
		return EAStyleManager.shared[style]?.set(to: self, range: range)
	}
	
	/// Apply a sequence of styles defied in global `EAStyleManager` to the receiver string.
	/// Unregistered styles are ignored.
	/// Sequence produces a single merge style where the each n+1 element of the sequence may
	/// override existing key set by previous applied style.
	/// Resulting attributes dictionary is threfore applied to the string.
	///
	/// - Parameters:
	///   - styles: ordered list of styles name to apply. EAStyleManager.shared must be registed in `EAStyleManager`.
	///   - range: range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: attributed string, `nil` if all specified styles required are not registered.
	public func set(styles: [String], range: NSRange? = nil) -> EAString? {
		return EAStyleManager.shared[styles]?.mergeStyle().set(to: self, range: range)
	}
	
	/// Apply passed style to the receiver string.
	///
	/// - Parameters:
	///   - style: style to apply.
	///   - range: range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: rendered attributed string.
	public func set(style: EAStyleProtocol, range: NSRange? = nil) -> EAString {
		return style.set(to: self, range: range)
	}
	
	/// Apply passed sequence of `EAStyleProtocol` instances to the receiver.
	/// Sequence produces a single merge style where the each n+1 element of the sequence may
	/// override existing key set by previous applied style.
	/// Resulting attributes dictionary is threfore applied to the string.
	///
	/// - Parameters:
	///   - styles: ordered list of styles to apply. EAStyleManager.shared must be registed in `EAStyleManager`.
	///   - range: range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: attributed string.
	public func set(styles: [EAStyleProtocol], range: NSRange? = nil) -> EAString {
		return styles.mergeStyle().set(to: self, range: range)
	}
	
}

//MARK: - Operations

/// Create a new attributed string using + where the left operand is a plain string and left is a style.
///
/// - Parameters:
///   - lhs: plain string.
///   - rhs: style to apply.
/// - Returns: rendered attributed string instance
public func + (lhs: String, rhs: EAStyleProtocol) -> EAString {
	return rhs.set(to: lhs, range: nil)
}

