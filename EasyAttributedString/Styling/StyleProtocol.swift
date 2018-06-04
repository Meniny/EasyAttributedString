//
//  EasyAttributedString
//
//  Created by Elias Abel
//  Copyright © 2018 Meniny Lab. All rights reserved.
//
//	Web: https://meniny.cn
//	Email: admin@meniny.cn
//	Twitter: @_Meniny
//

import Foundation

public typealias EasyAttributedString = NSMutableAttributedString
public typealias EAString = NSMutableAttributedString

public protocol EAStyleProtocol: class {
	
	/// Return the attributes of the style in form of dictionary `NSAttributedStringKey`/`Any`.
	var attributes: [NSAttributedStringKey : Any] { get }
	
	func set(to source: String, range: NSRange?) -> EAString
	func add(to source: EAString, range: NSRange?) -> EAString
	func set(to source: EAString, range: NSRange?) -> EAString
	func remove(from source: EAString, range: NSRange?) -> EAString
}

public extension EAStyleProtocol {
	
	func set(to source: String, range: NSRange?) -> EAString {
		guard let range = range else { // apply to entire string
			return NSMutableAttributedString(string: source, attributes: self.attributes)
		}
		let attributedText = NSMutableAttributedString(string: source)
		attributedText.setAttributes(self.attributes, range: range)
		return attributedText
	}
	
	func add(to source: EAString, range: NSRange?) -> EAString {
		source.addAttributes(self.attributes, range: (range ?? NSMakeRange(0, source.length)))
		return source
	}
	
	func set(to source: EAString, range: NSRange?) -> EAString {
		source.setAttributes(self.attributes, range: (range ?? NSMakeRange(0, source.length)))
		return source
	}
	
	func remove(from source: EAString, range: NSRange?) -> EAString {
		self.attributes.keys.forEach({
			source.removeAttribute($0, range: (range ?? NSMakeRange(0, source.length)))
		})
		return source
	}
	
}
