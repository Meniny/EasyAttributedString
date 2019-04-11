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

//MARK: - EAString Extension

// The following methods are used to alter an existing attributed string with attributes specified by styles.
public extension EAString {
	
	/// Append existing style's attributed, registered in `StyleManager`, to the receiver string (or substring).
	///
	/// - Parameters:
	///   - style: 	valid style name registered in `StyleManager`.
	///				If invalid, the same instance of the receiver is returned unaltered.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func add(style: String, range: NSRange? = nil) -> EAString {
		guard let style = EAStyleManager.shared[style] else { return self }
		return style.add(to: self, range: range)
	}
	
	/// Append ordered sequence of styles registered in `StyleManager` to the receiver.
	/// EAStyleManager.shared are merged in order to produce a single attribute dictionary which is therefore applied to the string.
	///
	/// - Parameters:
	///   - styles: ordered list of styles to apply.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func add(styles: [String], range: NSRange? = nil) -> EAString {
		guard let styles = EAStyleManager.shared[styles] else { return self }
		return styles.mergeStyle().set(to: self, range: range)
	}
	
	/// Replace any existing attributed string's style into the receiver/substring of the receiver
	/// with the style which has the specified name and is registered into `StyleManager`.
	///
	/// - Parameters:
	///   - style: style name to apply. EAStyle instance must be registered in `StyleManager` to be applied.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func set(style: String, range: NSRange? = nil) -> EAString {
		guard let style = EAStyleManager.shared[style] else { return self }
		return style.set(to: self, range: range)
	}
	
	/// Replace any existing attributed string's style into the receiver/substring of the receiver
	/// with a style which is an ordered merge of styles passed.
	/// EAStyleManager.shared are passed as name and you must register them into `StyleManager` before using this function.
	///
	/// - Parameters:
	///   - styles: styles name to apply. Instances must be registered into `StyleManager`.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func set(styles: [String], range: NSRange? = nil) -> EAString {
		guard let styles = EAStyleManager.shared[styles] else { return self }
		return styles.mergeStyle().set(to: self, range: range)
	}
	
	/// Append passed style to the receiver.
	///
	/// - Parameters:
	///   - style: style to apply.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func add(style: EAStyleProtocol, range: NSRange? = nil) -> EAString {
		return style.add(to: self, range: range)
	}
	
	/// Append passed sequences of styles to the receiver.
	/// Sequences are merged in order in a single style's attribute which is therefore applied to the string.
	///
	/// - Parameters:
	///   - styles: styles to apply, in order.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func add(styles: [EAStyleProtocol], range: NSRange? = nil) -> EAString {
		return styles.mergeStyle().add(to: self, range: range)
	}
	
	/// Replace the attributes of the string with passed style.
	///
	/// - Parameters:
	///   - style: style to apply.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func set(style: EAStyleProtocol, range: NSRange? = nil) -> EAString {
		return style.set(to: self, range: range)
	}
	
	/// Replace the attributes of the string with a style which is an ordered merge of passed
	/// styles sequence.
	///
	/// - Parameters:
	///   - styles: ordered list of styles to apply.
	///   - range: 	range of substring where style is applied, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func set(styles: [EAStyleProtocol], range: NSRange? = nil) -> EAString {
		return styles.mergeStyle().set(to: self, range: range)
	}
	
	/// Remove passed attribute's keys from the receiver.
	///
	/// - Parameters:
	///   - keys: attribute's keys to remove.
	///   - range: 	range of substring where style will be removed, `nil` to use the entire string.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	@discardableResult
	public func removeAttributes(_ keys: [NSAttributedString.Key], range: NSRange) -> Self {
		keys.forEach { self.removeAttribute($0, range: range) }
		return self
	}
	
	/// Remove all keys defined into passed style from the receiver.
	///
	/// - Parameter style: style to use.
	/// - Returns: 	same instance of the receiver with - eventually - modified attributes.
	public func remove(_ style: EAStyleProtocol) -> Self {
		self.removeAttributes(Array(style.attributes.keys), range: NSMakeRange(0, self.string.count))
		return self
	}
	
}

//MARK: - Operations

/// Merge two attributed string in a single new attributed string.
///
/// - Parameters:
///   - lhs: attributed string.
///   - rhs: attributed string.
/// - Returns: new attributed string concatenation of two strings.
public func + (lhs: EAString, rhs: EAString) -> EAString {
	let final = NSMutableAttributedString(attributedString: lhs)
	final.append(rhs)
	return final
}

/// Merge a plain string with an attributed string to produce a new attributed string.
///
/// - Parameters:
///   - lhs: plain string.
///   - rhs: attributed string.
/// - Returns: new attributed string.
public func + (lhs: String, rhs: EAString) -> EAString {
	let final = NSMutableAttributedString(string: lhs)
	final.append(rhs)
	return final
}

/// Merge an attributed string with a plain string to produce a new attributed string.
///
/// - Parameters:
///   - lhs: attributed string.
///   - rhs: plain string.
/// - Returns: new attributed string.
public func + (lhs: EAString, rhs: String) -> EAString {
	let final = NSMutableAttributedString(attributedString: lhs)
	final.append(NSMutableAttributedString(string: rhs))
	return final
}
