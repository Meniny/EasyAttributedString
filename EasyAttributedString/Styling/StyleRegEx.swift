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

/// EAStyleRegEx allows you to define a style which is applied when one or more regular expressions
/// matches are found in source string or attributed string.
public class EAStyleRegEx: EAStyleProtocol {
	
	//MARK: - PROPERTIES
	
	/// Regular expression
	public private(set) var regex: NSRegularExpression
	
	/// Base style. If set it will be applied in set before any match.
	public private(set) var baseStyle: EAStyleProtocol?
	
	/// Applied style
	private var style: EAStyleProtocol
	
	/// EAStyle attributes
	public var attributes: [NSAttributedStringKey : Any] {
		return self.style.attributes
	}
	
	//MARK: - INIT
	
	/// Initialize a new regular expression style matcher.
	///
	/// - Parameters:
	///   - base: base style. it will be applied (in set or add) to the entire string before any other operation.
	///   - pattern: pattern of regular expression.
	///   - options: matching options of the regular expression; if not specified `caseInsensitive` is used.
	///   - handler: configuration handler for style.
	public init?(base: EAStyleProtocol? = nil,
				 pattern: String, options: NSRegularExpression.Options = .caseInsensitive,
				 handler: @escaping EAStyle.StyleInitHandler) {
		do {
			self.regex = try NSRegularExpression(pattern: pattern, options: options)
			self.baseStyle = base
			self.style = EAStyle(handler)
		} catch {
			return nil
		}
	}
	
	//MARK: - METHOD OVERRIDES
	
	public func set(to source: String, range: NSRange?) -> EAString {
		let attributed = NSMutableAttributedString(string: source, attributes: (self.baseStyle?.attributes ?? [:]))
		return self.applyStyle(to: attributed, add: false, range: range)
	}
	
	public func add(to source: EAString, range: NSRange?) -> EAString {
		if let base = self.baseStyle {
			source.addAttributes(base.attributes, range: (range ?? NSMakeRange(0, source.string.count)))
		}
		return self.applyStyle(to: source, add: true, range: range)
	}
	
	public func set(to source: EAString, range: NSRange?) -> EAString {
		if let base = self.baseStyle {
			source.setAttributes(base.attributes, range: (range ?? NSMakeRange(0, source.string.count)))
		}
		return self.applyStyle(to: source, add: false, range: range)
	}
	
	//MARK: - INTERNAL FUNCTIONS
	
	/// Regular expression matcher.
	///
	/// - Parameters:
	///   - str: attributed string.
	///   - add: `true` to append styles, `false` to replace existing styles.
	///   - range: range, `nil` to apply the style to entire string.
	/// - Returns: modified attributed string
	private func applyStyle(to str: EAString, add: Bool, range: NSRange?) -> EAString {
		let rangeValue = (range ?? NSMakeRange(0, str.string.count))
		
		let matchOpts = NSRegularExpression.MatchingOptions(rawValue: 0)
		self.regex.enumerateMatches(in: str.string, options: matchOpts, range: rangeValue) {
			(result : NSTextCheckingResult?, _, _) in
			if let r = result {
				if add {
					str.addAttributes(self.attributes, range: r.range)
				} else {
					str.setAttributes(self.attributes, range: r.range)
				}
			}
		}
		
		return str
	}
	
}
