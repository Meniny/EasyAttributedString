//
//  EAFontInfo.swift
//  EasyAttributedString
//
//  Created by Daniele Margutti on 19/05/2018.
//  Copyright © 2018 EasyAttributedString. All rights reserved.
//

import Foundation
import Foundation
#if os(OSX)
import AppKit
#else
import UIKit
#endif

internal let TVOS_SYSTEMFONT_SIZE: CGFloat = 29.0
internal let WATCHOS_SYSTEMFONT_SIZE: CGFloat = 12.0

/// EAFontInfo is an internal struct which describe the inner attributes related to a font instance.
/// User don't interact with this object directly but via `EAStyle`'s properties.
/// Using the `attributes` property this object return a valid instance of the attributes to describe
/// required behaviour.
internal struct EAFontInfo {
	
	/// EAFont object
	var font: EAFontConvertible { didSet { self.style?.invalidateCache() } }
	
	/// Size of the font
	var size: CGFloat { didSet { self.style?.invalidateCache() } }
	
	#if os(OSX) || os(iOS) || os(tvOS)
	
	/// Configuration for the number case, also known as "figure style".
	var numberCase: EANumberCase? { didSet { self.style?.invalidateCache() } }
	
	/// Configuration for number spacing, also known as "figure spacing".
	var numberSpacing: EANumberSpacing? { didSet { self.style?.invalidateCache() } }
	
	/// Configuration for displyaing a fraction.
	var fractions: EAFractions? { didSet { self.style?.invalidateCache() } }
	
	/// Superscript (superior) glpyh variants are used, as in footnotes¹.
	var superscript: Bool? { didSet { self.style?.invalidateCache() } }
	
	/// Subscript (inferior) glyph variants are used: vₑ.
	var `subscript`: Bool? { didSet { self.style?.invalidateCache() } }
	
	/// Ordinal glyph variants are used, as in the common typesetting of 4th.
	var ordinals: Bool? { didSet { self.style?.invalidateCache() } }
	
	/// Scientific inferior glyph variants are used: H₂O
	var scientificInferiors: Bool? { didSet { self.style?.invalidateCache() } }
	
	/// Configure small caps behavior.
	/// `fromUppercase` and `fromLowercase` can be combined: they are not mutually exclusive.
	var smallCaps: Set<EASmallCaps> = [] { didSet { self.style?.invalidateCache() } }
	
	/// Different stylistic alternates available for customizing a font.
	var stylisticAlternates: EAStylisticAlternates = EAStylisticAlternates() { didSet { self.style?.invalidateCache() } }
	
	/// Different contextual alternates available for customizing a font.
	var contextualAlternates: EAContextualAlternates = EAContextualAlternates() { didSet { self.style?.invalidateCache() } }
	
	/// Describe trait variants to apply to the font.
	var traitVariants: EAStringTraitVariant? { didSet { self.style?.invalidateCache() } }
	
	/// Tracking to apply.
	var kerning: EAStringKerning? { didSet { self.style?.invalidateCache() } }
	
	#endif
	
	/// Reference to parent style (used to invalidate cache; we can do better).
	weak var style: EAStyle?
	
	/// Initialize a new `EAFontInfo` instance with system font with system font size.
	init() {
		#if os(tvOS)
		self.font = EAFont.systemFont(ofSize: TVOS_SYSTEMFONT_SIZE)
		self.size = TVOS_SYSTEMFONT_SIZE
		#elseif os(watchOS)
		self.font = EAFont.systemFont(ofSize: WATCHOS_SYSTEMFONT_SIZE)
		self.size = WATCHOS_SYSTEMFONT_SIZE
		#else
		self.font = EAFont.systemFont(ofSize: EAFont.systemFontSize)
		self.size = EAFont.systemFontSize
		#endif
	}
	
	/// Return a font with all attributes set.
	///
	/// - Parameter size: ignored. It will be overriden by `fontSize` property.
	/// - Returns: instance of the font
	var attributes: [NSAttributedString.Key:Any] {
		var finalAttributes: [NSAttributedString.Key:Any] = [:]
		
		// generate an initial font from passed EAFontConvertible instance
		var finalFont = self.font.font(size: self.size)
		
		// compose the attributes
		#if os(iOS) || os(tvOS) || os(OSX)
		var attributes: [EAFontInfoAttribute] = []

		attributes += [self.numberCase].compactMap { $0 }
		attributes += [self.fractions].compactMap { $0 }
		attributes += [self.superscript].compactMap { $0 }.map { ($0 == true ? EAVerticalPosition.superscript : EAVerticalPosition.normal) } as [EAFontInfoAttribute]
		attributes += [self.subscript].compactMap { $0 }.map { ($0 ? EAVerticalPosition.`subscript` : EAVerticalPosition.normal) } as [EAFontInfoAttribute]
		attributes += [self.ordinals].compactMap { $0 }.map { $0 ? EAVerticalPosition.ordinals : EAVerticalPosition.normal } as [EAFontInfoAttribute]
		attributes += [self.scientificInferiors].compactMap { $0 }.map { $0 ? EAVerticalPosition.scientificInferiors : EAVerticalPosition.normal } as [EAFontInfoAttribute]
		attributes += self.smallCaps.map { $0 as EAFontInfoAttribute }
		attributes += [self.stylisticAlternates as EAFontInfoAttribute]
		attributes += [self.contextualAlternates as EAFontInfoAttribute]
		
		finalFont = finalFont.withAttributes(attributes)
		
		
		if let traitVariants = self.traitVariants { // manage emphasis
			let descriptor = finalFont.fontDescriptor
			let existingTraits = descriptor.symbolicTraits
			let newTraits = existingTraits.union(traitVariants.symbolicTraits)
			
			// Explicit cast to optional because withSymbolicTraits returns an
			// optional on Mac, but not on iOS.
			let newDescriptor: EAFontDescriptor? = descriptor.withSymbolicTraits(newTraits)
			if let newDesciptor = newDescriptor {
				#if os(OSX)
				finalFont = EAFont(descriptor: newDesciptor, size: 0)!
				#else
				finalFont = EAFont(descriptor: newDesciptor, size: 0)
				#endif
			}
		}
		
		if let tracking = self.kerning { // manage kerning attributes
			finalAttributes[.kern] = tracking.kerning(for: finalFont)
		}
		#endif
		
		finalAttributes[.font] = finalFont // assign composed font
		return finalAttributes
	}
	
}
