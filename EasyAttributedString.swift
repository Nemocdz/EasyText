import Foundation

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

public struct EasyText {
    public let attributedString: NSAttributedString
}

extension EasyText: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        attributedString = NSAttributedString(string: stringLiteral)
    }
}

extension EasyText: CustomStringConvertible {
    public var description: String {
        return String(describing: attributedString)
    }
}

extension EasyText: ExpressibleByStringInterpolation {
    public init(stringInterpolation: StringInterpolation) {
        attributedString = NSAttributedString(attributedString: stringInterpolation.rawAttributedString)
    }
    
    public struct StringInterpolation:StringInterpolationProtocol {
        let rawAttributedString:NSMutableAttributedString
        
        public init(literalCapacity: Int, interpolationCount: Int) {
            rawAttributedString = NSMutableAttributedString()
        }
        
        public func appendLiteral(_ literal:String) {
            rawAttributedString.append(NSAttributedString(string: literal))
        }

        public func appendInterpolation(_ string:String, attributesDic:[NSAttributedString.Key: Any]) {
            rawAttributedString.append(NSAttributedString(string: string, attributes: attributesDic))
        }

        public func appendInterpolation(_ string:String, _ attributes:EasyText.Style...) {
            let attributesDic = [NSAttributedString.Key: Any](uniqueKeysWithValues: attributes.flatMap{ $0.attributeKeyValues } )
            rawAttributedString.append(NSAttributedString(string: string, attributes: attributesDic))
        }
            
        public func appendInterpolation(attributedString: EasyText, _ attributes: EasyText.Style...) {
            let attributesDic = [NSAttributedString.Key: Any](uniqueKeysWithValues: attributes.flatMap{ $0.attributeKeyValues })
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString.attributedString)
            let range = NSRange(mutableAttributedString.string.startIndex..<mutableAttributedString.string.endIndex, in: mutableAttributedString.string)
            mutableAttributedString.addAttributes(attributesDic, range: range)
            rawAttributedString.append(mutableAttributedString)
        }
        
        public func appendInterpolation(attachment:NSTextAttachment) {
            rawAttributedString.append(NSAttributedString(attachment: attachment))
        }
        
        #if os(macOS)
        public typealias Image = NSImage
        #elseif os(iOS)
        public typealias Image = UIImage
        #endif
        
        @available(iOS 9.0, *)
        @available(OSX 10.0, *)
        public func appendInterpolation(image:Image, bounds:CGRect = .zero) {
            let attachment = NSTextAttachment(image: image)
            attachment.bounds = bounds
            rawAttributedString.append(NSAttributedString(attachment: attachment))
        }
    }
}

extension EasyText {
    public struct Style {
        public typealias AttributeKeyValue = (NSAttributedString.Key, Any)

        #if os(macOS)
        public typealias Font = NSFont
        public typealias Color = NSColor
        public typealias Size = NSSize
        #elseif os(iOS)
        public typealias Font = UIFont
        public typealias Color = UIColor
        public typealias Size = CGSize
        #elseif os(watchOS)
        public typealias Font = UIFont
        public typealias Color = UIColor
        public typealias Size = CGSize
        #endif
        
        let attributeKeyValues:[AttributeKeyValue]
        
        public init(attributeKeyValue:AttributeKeyValue...) {
            attributeKeyValues = attributeKeyValue
        }
        
        public static func paragrahStyle(_ style:NSParagraphStyle) -> Style {
            return Style(attributeKeyValue: (.paragraphStyle, style))
        }
        
        public static func paragrahStyle(lineSpacing:CGFloat = 0,
                                         paragraphSpacing:CGFloat = 0,
                                         alignment:NSTextAlignment = .natural,
                                         headIndent:CGFloat = 0,
                                         tailIndent:CGFloat = 0,
                                         firstLineHeadIndent:CGFloat = 0,
                                         minLineHeight:CGFloat = 0,
                                         maxLineHeight:CGFloat = 0,
                                         lineBreakMode:NSLineBreakMode = .byWordWrapping,
                                         writingDirection:NSWritingDirection = .natural,
                                         lineHeightMultiple:CGFloat = 0,
                                         pargraphSpacingBefore:CGFloat = 0,
                                         hyphenationFactor:Float = 0,
                                         tabStops:[NSTextTab] = [],
                                         defaultTabInterval:CGFloat = 0,
                                         allowsDefaultTighteningForTruncation:Bool = false) -> Style {
            let paragrahStyle = NSMutableParagraphStyle()
            paragrahStyle.setParagraphStyle(NSParagraphStyle.default)
            paragrahStyle.lineSpacing = lineSpacing
            paragrahStyle.paragraphSpacing = paragraphSpacing
            paragrahStyle.alignment = alignment
            paragrahStyle.headIndent = headIndent
            paragrahStyle.tailIndent = tailIndent
            paragrahStyle.firstLineHeadIndent = firstLineHeadIndent
            paragrahStyle.minimumLineHeight = minLineHeight
            paragrahStyle.maximumLineHeight = maxLineHeight
            paragrahStyle.lineBreakMode = lineBreakMode
            paragrahStyle.baseWritingDirection = writingDirection
            paragrahStyle.lineHeightMultiple = lineHeightMultiple
            paragrahStyle.paragraphSpacingBefore = pargraphSpacingBefore
            paragrahStyle.hyphenationFactor = hyphenationFactor
            paragrahStyle.defaultTabInterval = defaultTabInterval
            paragrahStyle.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
            tabStops.forEach{ paragrahStyle.addTabStop($0) }
            return Style(attributeKeyValue: (.paragraphStyle, paragrahStyle))
        }
        
        public static func font(_ font:Font) -> Style {
            return Style(attributeKeyValue: (.font, font))
        }
        
        public static func color(_ color:Color) -> Style {
            return Style(attributeKeyValue: (.foregroundColor, color))
        }
        
        public static func backgroundColor(_ color:Color) -> Style {
            return Style(attributeKeyValue: (.backgroundColor, color))
        }
        
        public enum LigatureOption:Int {
            case none = 0
            case `default`
            #if os(macOS)
            case all
            #endif
        }
        
        public static func ligature(_ option:LigatureOption) -> Style {
            return Style(attributeKeyValue: (.ligature, option.rawValue))
        }
        
        public static func kern(_ kern:CGFloat) -> Style {
            return Style(attributeKeyValue: (.kern, kern))
        }
        
        public static func strikethrough(style:NSUnderlineStyle, color:Color? = nil) -> Style {
            if let color = color {
                return Style(attributeKeyValue: (.strikethroughStyle, style.rawValue), (.strikethroughColor, color))
            } else {
                return Style(attributeKeyValue: (.strikethroughStyle, style.rawValue))
            }
        }
        
        public static func underline(_ style:NSUnderlineStyle, color:Color? = nil) -> Style {
            if let color = color {
                return Style(attributeKeyValue: (.underlineStyle, style.rawValue), (.underlineColor, color))
            } else {
                return Style(attributeKeyValue: (.underlineStyle, style.rawValue))
            }
        }
        
        public static func stroke(width:CGFloat, color:Color? = nil) -> Style {
            if let color = color {
                return Style(attributeKeyValue: (.strokeWidth, width), (.strokeColor, color))
            } else {
                return Style(attributeKeyValue: (.strokeWidth, width))
            }
        }
        
        public static func shadow(_ shadow:NSShadow) -> Style {
            return Style(attributeKeyValue: (.shadow, shadow))
        }
        
        public static func shadow(color:Color? = nil, offset:Size = .zero, bulrRadius:CGFloat = 0) -> Style {
            let shadow = NSShadow()
            if let color = color {
                shadow.shadowColor = color
            }
            shadow.shadowOffset = offset
            shadow.shadowBlurRadius = bulrRadius
            return Style(attributeKeyValue: (.shadow, shadow))
        }
        
        public static func textEffect(_ style:NSAttributedString.TextEffectStyle) -> Style {
            return Style(attributeKeyValue: (.textEffect, style.rawValue))
        }
        
        public static func link(_ link:String) -> Style {
           return Style(attributeKeyValue: (.link, link))
        }
        
        public static func link(_ link:URL) -> Style {
            return Style(attributeKeyValue: (.link, link))
        }
        
        public static func baselineOffset(_ offset:CGFloat) -> Style {
            return Style(attributeKeyValue: (.baselineOffset, offset))
        }
        
        public static func obliqueness(_ skew:CGFloat) -> Style {
            return Style(attributeKeyValue: (.obliqueness, skew))
        }
        
        public static func expansion(_ expansion:CGFloat) -> Style {
            return Style(attributeKeyValue: (.expansion, expansion))
        }
        
        public static func writingDirection(_ direction:NSWritingDirection, type:NSWritingDirectionFormatType = .embedding) -> Style {
            return Style(attributeKeyValue: (.writingDirection, [direction.rawValue | type.rawValue]))
        }
        
        public enum VericalGlyphFormOption:Int {
            case horizontal = 0
            #if os(macOS)
            case vertical
            #endif
        }
        
        public static func vericalGlyphForm(_ option:VericalGlyphFormOption) -> Style {
            return Style(attributeKeyValue: (.verticalGlyphForm, option.rawValue))
        }
    }
}
