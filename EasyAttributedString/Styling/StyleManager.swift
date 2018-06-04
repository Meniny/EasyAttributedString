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

/// EAStyleManager act as a central repository where you can register your own style and use
/// globally in your app.
public class EAStyleManager {
	
	/// Singleton instance.
	public static let shared: EAStyleManager = EAStyleManager()
	
	/// You can defeer the creation of a style to the first time its required.
	/// Implementing this method you will receive a call with the name of the style
	/// you are about to provide and you have a chance to make and return it.
	/// Once returned the style is automatically cached.
	public var onDeferStyle: ((String) -> (EAStyleProtocol?, Bool))? = nil
	
	/// Registered styles.
	public private(set) var styles: [String: EAStyleProtocol] = [:]
	
	/// Register a new style with given name.
	///
	/// - Parameters:
	///   - name: unique identifier of style.
	///   - style: style to register.
	public func register(_ name: String, style: EAStyleProtocol) {
		self.styles[name] = style
	}

	/// Return a style registered with given name.
	///
	/// - Parameter name: name of the style
	public subscript(name: String?) -> EAStyleProtocol? {
		guard let name = name else { return nil }
		
		if let cachedStyle = self.styles[name] { // style is cached
			return cachedStyle
		} else {
			// check if user can provide a deferred creation for this style
			if let (deferredStyle,canCache) = self.onDeferStyle?(name) {
				// cache if requested
				if canCache, let dStyle = deferredStyle { self.styles[name] = dStyle }
				return deferredStyle
			}
			return nil // nothing
		}
	}
	
	/// Return a list of styles registered with given names.
	///
	/// - Parameter names: array of style's name to get.
	public subscript(names: [String]?) -> [EAStyleProtocol]? {
		guard let names = names else { return nil }
		return names.compactMap { self.styles[$0] }
	}
	
}
