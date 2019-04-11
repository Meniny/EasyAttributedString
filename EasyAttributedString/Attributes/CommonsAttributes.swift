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
import CoreGraphics

//MARK: - Typealiases

#if os(OSX)
import AppKit

public typealias EAColor = NSColor
public typealias EAImage = NSImage
public typealias EAFont = NSFont
public typealias EAFontDescriptor = NSFontDescriptor
public typealias EASymbolicTraits = NSFontDescriptor.SymbolicTraits
//public typealias EALineBreak = NSParagraphStyle.NSLineBreakMode
public typealias EALineBreak = NSLineBreakMode

let EAFontDescriptorFeatureSettingsAttribute = NSFontDescriptor.AttributeName.featureSettings
let EAFontFeatureTypeIdentifierKey = NSFontDescriptor.FeatureKey.typeIdentifier
let EAFontFeatureSelectorIdentifierKey = NSFontDescriptor.FeatureKey.selectorIdentifier

extension NSColor {
    public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(srgbRed: red, green: green, blue: blue, alpha: alpha)
    }
}

#else
import UIKit

public typealias EAColor = UIColor
public typealias EAImage = UIImage
public typealias EAFont = UIFont
public typealias EAFontDescriptor = UIFontDescriptor
public typealias EASymbolicTraits = UIFontDescriptor.SymbolicTraits
public typealias EALineBreak = NSLineBreakMode

let EAFontDescriptorFeatureSettingsAttribute = UIFontDescriptor.AttributeName.featureSettings
let EAFontFeatureTypeIdentifierKey = UIFontDescriptor.FeatureKey.featureIdentifier
let EAFontFeatureSelectorIdentifierKey = UIFontDescriptor.FeatureKey.typeIdentifier

#endif

//MARK: - EAStringKerning

/// An enumeration representing the tracking to be applied.
///
/// - point: point value.
/// - adobe: adobe format point value.
public enum EAStringKerning {
    case point(CGFloat)
    case adobe(CGFloat)
    
    public func kerning(for font: EAFont?) -> CGFloat {
        switch self {
        case .point(let kernValue):
            return kernValue
        case .adobe(let adobeTracking):
            let AdobeTrackingDivisor: CGFloat = 1000.0
            if font == nil {
                print("Missing font for apply tracking; 0 is the fallback.")
            }
            return (font?.pointSize ?? 0) * (adobeTracking / AdobeTrackingDivisor)
        }
    }
    
}

//MARK: - EAStringLigatures

/// EAStringLigatures cause specific character combinations to be rendered using a single custom glyph that corresponds
/// to those characters.
///
/// - disabled: use only required ligatures when setting text, for the glyphs in the selection
///                if the receiver is a rich text view, or for all glyphs if it’s a plain text view.
/// - defaults: use the standard ligatures available for the fonts and languages used when setting text,
///                for the glyphs in the selection if the receiver is a rich text view, or for all glyphs if it’s a plain text view.
/// - all:         use all ligatures available for the fonts and languages used when setting text, for the glyphs
///                in the selection if the receiver is a rich text view, or for all glyphs if it’s a
///                plain text view (not supported on iOS).
public enum EAStringLigatures: Int {
    case disabled = 0
    case defaults = 1
    #if os(OSX)
    case all = 2
    #endif
}

//MARK: - EAStringHeadingLevel

/// Specify the heading level of the text.
/// Value is a number in the range 0 to 6.
/// Use 0 to indicate the absence of a specific heading level and use other numbers to indicate the heading level.
///
/// - none: no heading
/// - one: level 1
/// - two: level 2
/// - three: level 3
/// - four: level 4
/// - five: level 5
/// - six: level 6
public enum EAStringHeadingLevel: Int {
    case none = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
}

//MARK: - Trait Variants

/// Describe a trait variant for font
public struct EAStringTraitVariant: OptionSet {
    public var rawValue: Int
    
    /// The font typestyle is italic
    public static let italic = EAStringTraitVariant(rawValue: 1 << 0)
    
    /// The font typestyle is boldface
    public static let bold = EAStringTraitVariant(rawValue: 1 << 1)
    
    // The font typestyle is expanded. Expanded and condensed traits are mutually exclusive.
    public static let expanded = EAStringTraitVariant(rawValue: 1 << 2)
    
    /// The font typestyle is condensed. Expanded and condensed traits are mutually exclusive
    public static let condensed = EAStringTraitVariant(rawValue: 1 << 3)
    
    /// The font uses vertical glyph variants and metrics.
    public static let vertical = EAStringTraitVariant(rawValue: 1 << 4)
    
    /// The font synthesizes appropriate attributes for user interface rendering, such as control titles, if necessary.
    public static let uiOptimized = EAStringTraitVariant(rawValue: 1 << 5)
    
    /// The font use a tigher line spacing variant.
    public static let tightLineSpacing = EAStringTraitVariant(rawValue: 1 << 6)
    
    /// The font use a loose line spacing variant.
    public static let looseLineSpacing = EAStringTraitVariant(rawValue: 1 << 7)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}


extension EAStringTraitVariant {
    
    var symbolicTraits: EASymbolicTraits {
        var traits: EASymbolicTraits = []
        if contains(.italic) {
            traits.insert(EASymbolicTraits.italic)
        }
        if contains(.bold) {
            traits.insert(.bold)
        }
        if contains(.expanded) {
            traits.insert(.expanded)
        }
        if contains(.condensed) {
            traits.insert(.condensed)
        }
        if contains(.vertical) {
            traits.insert(.vertical)
        }
        if contains(.uiOptimized) {
            traits.insert(.uiOptimized)
        }
        if contains(.tightLineSpacing) {
            traits.insert(.tightLineSpacing)
        }
        if contains(.looseLineSpacing) {
            traits.insert(.looseLineSpacing)
        }
        
        return traits
    }
    
}

//MARK: - Symbolic Traits (UIFontDescriptorSymbolicTraits) Extensions

extension EASymbolicTraits {
    #if os(iOS) || os(tvOS) || os(watchOS)
    static var italic: EASymbolicTraits {
        return .traitItalic
    }
    static var bold: EASymbolicTraits {
        return .traitBold
    }
    static var expanded: EASymbolicTraits {
        return .traitExpanded
    }
    static var condensed: EASymbolicTraits {
        return .traitCondensed
    }
    static var vertical: EASymbolicTraits {
        return .traitVertical
    }
    static var uiOptimized: EASymbolicTraits {
        return .traitUIOptimized
    }
    static var tightLineSpacing: EASymbolicTraits {
        return .traitTightLeading
    }
    static var looseLineSpacing: EASymbolicTraits {
        return .traitLooseLeading
    }
    #else
    static var uiOptimized: EASymbolicTraits {
        return .UIOptimized
    }
    static var tightLineSpacing: EASymbolicTraits {
        return .tightLeading
    }
    static var looseLineSpacing: EASymbolicTraits {
        return .looseLeading
    }
    #endif
}

