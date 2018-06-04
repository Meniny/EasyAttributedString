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

public extension Array where Array.Element == Range<String.Index> {
	
	/// Convert an array of `String.Index` to an array of `NSRange`
	public var nsRanges: [NSRange] {
		return self.map({ $0.nsRange })
	}
	
}

public extension Range where Bound == String.Index {
	
	/// Return `NSRange` from standard `Range<String.Index>` range.
	var nsRange:NSRange {
		return NSRange(location: self.lowerBound.encodedOffset,
					   length: self.upperBound.encodedOffset -
						self.lowerBound.encodedOffset)
	}
}

public extension NSRange {
	
	/// Convert receiver in String's `Range<String.Index>` for given string instance.
	///
	/// - Parameter str: source string
	/// - Returns: range, `nil` if invalid
	public func `in`(_ str: String) -> Range<String.Index>? {
		return Range(self, in: str)
	}
	
}

// MARK: - Subrange Subscript
public extension String {
	
	/// Convert an NSRange to String range.
	///
	/// - Parameter nsRange: origin NSRange instance.
	/// - Returns: Range<String.Index>
	func rangeFrom(nsRange : NSRange) -> Range<String.Index>? {
		return Range(nsRange, in: self)
	}
	
	/// Return substring from receiver starting at given index for a given length.
	/// Return `nil` for invalid ranges.
	///
	///
	/// - Parameters:
	///   - from: starting index.
	///   - length: length of string,
	/// - Returns: substring
	public func substring(from: Int?, length: Int) -> String? {
		guard length > 0 else { return nil }
		let start = from ?? 0
		let end = min(count, max(0, start) + length)
		guard start < end else { return nil }
		return self[start..<end]?.string
	}
	
	/// Allows to get a single character at index.
	/// `String[1]`
	///
	/// - Parameter index: index of the character
	/// - Returns: `Character` instance at passed index, `nil` if range is out of bounds.
	public subscript(index: Int) -> Character? {
		guard !self.isEmpty, let stringIndex = self.index(startIndex, offsetBy: index, limitedBy: self.index(before: endIndex)) else { return nil }
		return self[stringIndex]
	}
	
	
	/// Allows to get a substring at specified range.
	/// `String[0..<1]`
	///
	/// - Parameter value: substring
	public subscript(range: Range<Int>) -> Substring? {
		guard let left = offset(by: range.lowerBound) else { return nil }
		guard let right = index(left, offsetBy: range.upperBound - range.lowerBound,
								limitedBy: endIndex) else { return nil }
		return self[left..<right]
	}
	
	/// Allows to get a substring for a specified closed partial subrange.
	/// `String[..<1]`
	///
	/// - Parameter value: substring
	public subscript(value: PartialRangeUpTo<Int>) -> Substring? {
		if value.upperBound < 0 {
			guard abs(value.upperBound) <= count else { return nil }
			return self[..<(count - abs(value.upperBound))]
		}
		guard let right = offset(by: value.upperBound) else { return nil }
		return self[..<right]
	}
	
	/// Allows to get a substring for a specified closed subrange.
	/// `String[...1]`
	///
	/// - Parameter range: closed subrange.
	public subscript(range: ClosedRange<Int>) -> Substring? {
		if range.upperBound < 0 {
			guard abs(range.lowerBound) <= count else { return nil }
			return self[(count - abs(range.lowerBound))...]
		}
		guard let left = offset(by: range.lowerBound) else { return nil }
		guard let right = index(left, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
		return self[left...right]
	}
	
	/// Allows to get a substring for a specified partial range.
	/// `String[1...]`
	///
	/// - Parameter value: substring
	public subscript(value: PartialRangeFrom<Int>) -> Substring? {
		guard let left = self.offset(by: value.lowerBound) else { return nil }
		return self[left...]
	}
	
	/// Allows to get a substring starting for a given number of characters.
	/// `String[...2]`
	///
	/// - Parameter value: substring
	public subscript(value: PartialRangeThrough<Int>) -> Substring? {
		guard let right = self.offset(by: value.upperBound) else { return nil }
		return self[...right]
	}
	
	
	internal func offset(by distance: Int) -> String.Index? {
		return index(startIndex, offsetBy: distance, limitedBy: endIndex)
	}
	
	/// Return a new string by removing given prefix.
	///
	/// - Parameter prefix: prefix to remove.
	/// - Returns: new instance of the string without the prefix
	public func removing(prefix: String) -> String {
		if hasPrefix(prefix) {
			let start = index(startIndex, offsetBy: prefix.count)
			//			return substring(from: start)
			return self[start...].string
		}
		return self
	}
	
	public func removing(suffix: String) -> String {
		if hasSuffix(suffix) {
			let end = index(startIndex, offsetBy: self.count-suffix.count)
			return self[..<end].string
		}
		return self
	}
}

public extension Substring {
	
	/// Convert a `Substring` to a valid `String`
	var string: String {
		return String(self)
	}
}
