//
//  YSFHTMLElement.h
//  YSFCoreText
//
//  Created by Oliver Drobnik on 4/14/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSFCoreTextParagraphStyle;
@class YSFCoreTextFontDescriptor;
@class YSFTextAttachment;
@class YSFCSSListStyle;

#import "DTCompatibility.h"
#import "DTCoreTextConstants.h"
#import "DTHTMLParserNode.h"
#import "DTTextAttachment.h"

@class YSFBreakHTMLElement;

/**
 Class to represent a element (aka "tag") in a HTML document. Structure information - like parent or children - is inherited from its superclass <YSFHTMLParserNode>.
 */
@interface YSFHTMLElement : YSFHTMLParserNode
{
	YSFCoreTextFontDescriptor *_fontDescriptor;
	YSFCoreTextParagraphStyle *_paragraphStyle;
	YSFTextAttachment *_textAttachment;
	YSFTextAttachmentVerticalAlignment _textAttachmentAlignment;
	NSURL *_link;
	NSString *_anchorName;
	
	YSFColor *_textColor;
	YSFColor *_backgroundColor;
	
	YSFColor *_backgroundStrokeColor;
	CGFloat _backgroundStrokeWidth;
	CGFloat _backgroundCornerRadius;
	
	CTUnderlineStyle _underlineStyle;
	
	NSString *_beforeContent;
	
	NSString *_linkGUID;
	
	BOOL _strikeOut;
	NSInteger _superscriptStyle;
	
	NSInteger _headerLevel;
	
	NSArray *_shadows;
	
	YSFHTMLElementDisplayStyle _displayStyle;
	YSFHTMLElementFloatStyle _floatStyle;
	
	BOOL _isColorInherited;
	
	BOOL _preserveNewlines;
	BOOL _containsAppleConvertedSpace;
	
	YSFHTMLElementFontVariant _fontVariant;
	
	CGFloat _textScale;
	CGSize _size;
	
	NSMutableArray *_children;
	
	NSDictionary *_styles;
	
	BOOL _didOutput;
	
	// margins/padding
	YSFEdgeInsets _margins;
	YSFEdgeInsets _padding;
	
	// indent of lists
	CGFloat _listIndent;
	
	BOOL _shouldProcessCustomHTMLAttributes;
}

/**
 @name Creating HTML Elements
 */

/**
 Designed initializer, creates the appropriate element sub type
 @param name The element name
 @param attributes The attributes dictionary of the tag
 @param options The parsing options dictionary
 @returns the initialized element
 */
+ (YSFHTMLElement *)elementWithName:(NSString *)name attributes:(NSDictionary *)attributes options:(NSDictionary *)options;


/**
 @name Creating Attributed Strings
 */

/**
 Creates an `NSAttributedString` that represents the receiver including all its children. This method is typically overwritten in subclasses of <YSFHTMLElement> that represent specific HTML elements.
 @returns An attributed string that also contains the children
 */
- (NSAttributedString *)attributedString;

/**
 The dictionary of Core Text attributes for creating an `NSAttributedString` representation for the receiver
 @returns The dictionary of attributes
 */
- (NSDictionary *)attributesForAttributedStringRepresentation;

/**
 Creates a <YSFCSSListStyle> to match the CSS styles
 */
- (YSFCSSListStyle *)listStyle;


/**
 @name Getting Element Information
 */

/**
 Font Descriptor describing the font state of the receiver
 */
@property (nonatomic, copy) YSFCoreTextFontDescriptor *fontDescriptor;

/**
 Paragraph Style describing the paragraph state of the receiver
 */
@property (nonatomic, copy) YSFCoreTextParagraphStyle *paragraphStyle;

/**
 Text Attachment of the receiver, or `nil` if there is no attachment
 */
@property (nonatomic, strong) YSFTextAttachment *textAttachment;

/**
 Hyperlink URL of the receiver, or `nil` if there is no hyperlink
 */
@property (nonatomic, copy) NSURL *link;

/**
 Anchor name, used by hyperlinks, of the receiver that can be used to scroll to.
 */
@property (nonatomic, copy) NSString *anchorName;

/**
 Foreground text color of the receiver
 */
@property (nonatomic, strong) YSFColor *textColor;

/**
 Background color of text in the receiver
 */
@property (nonatomic, strong) YSFColor *backgroundColor;

/**
 Background stroke color in the receiver
 */
@property (nonatomic, strong) YSFColor *backgroundStrokeColor;

/**
 Background stroke width in the receiver
 */
@property (nonatomic, assign) CGFloat backgroundStrokeWidth;

/**
 Background stroke width in the receiver
 */
@property (nonatomic, assign) CGFloat backgroundCornerRadius;

/**
 The custom letter spacing of the receiver, default is 0px
 */
@property (nonatomic, assign) CGFloat letterSpacing;

/**
 Additional text to be inserted before the text content of the receiver
 */
@property (nonatomic, copy) NSString *beforeContent;

/**
 Array of shadows attached to the text contents of the receiver
 */
@property (nonatomic, copy) NSArray *shadows;

/**
 The underline style of the receiver, at present only none or single line are supported
 */
@property (nonatomic, assign) CTUnderlineStyle underlineStyle;

/**
 The strike-out style of the receiver
 */
@property (nonatomic, assign) BOOL strikeOut;

/**
 The superscript style of the receiver or 0 if it does not have superscript text.
 */
@property (nonatomic, assign) NSInteger superscriptStyle;

/**
 The header level of the receiver, or 0 if it is not a header
 */
@property (nonatomic, assign) NSInteger headerLevel;

/**
 The display style of the receiver.
 */
@property (nonatomic, assign) YSFHTMLElementDisplayStyle displayStyle;

/**
 Whether the receiver is marked as float. While floating is not currently supported this can be used to add additional paragraph breaks.
 */
@property (nonatomic, readonly) YSFHTMLElementFloatStyle floatStyle;

/**
 Specifies that the textColor was inherited. Assigning textColor sets this flag to `NO`
 */
@property (nonatomic, assign) BOOL isColorInherited;

/**
 Specifies that whitespace and new lines should be preserved. Default is to compress white space.
 */
@property (nonatomic, assign) BOOL preserveNewlines;

/**
 The current font variant of the receiver, normal or small caps.
 */

@property (nonatomic, assign) YSFHTMLElementFontVariant fontVariant;

/**
 The current unscaled font size (used when inheriting font size). You're probably looking for fontDescriptor.pointSize.
 */
@property (nonatomic, assign) CGFloat currentTextSize;

/**
 The scale by which all fonts are scaled
 */
@property (nonatomic, assign) CGFloat textScale;

/**
 The size of the receiver, either from width/height attributes or width/hight styles.
 */
@property (nonatomic, assign) CGSize size;

/**
 The value of the CSS margins. Margin support is incomplete.
 */
@property (nonatomic, assign) YSFEdgeInsets margins;

/** The value of the CSS padding. Padding are added to YSFTextBlock instances for block-level elements.
 */
@property (nonatomic, assign) YSFEdgeInsets padding;

/**
 Specifies that whitespace contained in the receiver's text has been converted with Apple's algorithm.
 */
@property (nonatomic, assign) BOOL containsAppleConvertedSpace;

/**
 Prevents adding custom HTML attributes to output
 */
@property (nonatomic, assign) BOOL shouldProcessCustomHTMLAttributes;

/**
 @name Working with HTML Attributes
 */

/**
 Retrieves an attribute with a given key
 @param key The attribute name to retrieve
 @returns the attribute string
 */
- (NSString *)attributeForKey:(NSString *)key;

/**
 Copies and inherits relevant attributes from the given parent element
 @param element The element to inherit attributes from
 */
- (void)inheritAttributesFromElement:(YSFHTMLElement *)element;

/**
 Interprets the tag attributes for e.g. writing direction. Usually you would call this after inheritAttributesFromElement:.
 */
- (void)interpretAttributes;

/**
 The HTML attributes that should be attached to the generated attributed string. Typically all attributes that were processed by -interpretAttributes are in this list. All other attributes get added to the generated attributed string with the YSFCustomAttributesAttribute key.
 */
+ (NSSet *)attributesToIgnoreForCustomAttributesAttribute;

/**
 The CSS class names that are not to be added to the "class" custom attribute in the YSFCustomAttributesAttribute key. Those are usually the class names 
 */
@property(nonatomic, strong) NSSet *CSSClassNamesToIgnoreForCustomAttributes;

/**
 @name Working with CSS Styles
 */

/**
 Applies the style information contained in a styles dictionary to the receiver
 @param styles A style dictionary
 */
- (void)applyStyleDictionary:(NSDictionary *)styles;


/**
 @name HTML Node Hierarchy
 */

/**
 Returns the parent element. That's the same as the parent node but with adjusted type for convenience.
 */
- (YSFHTMLElement *)parentElement;


/**
 @name Output State (Internal)
 */

/**
 Internal state during string building to mark the receiver as having been flushed
 */
@property (nonatomic, assign) BOOL didOutput;

/**
 Internal method that determines if this element still requires output, based on its own didOutput
 state and the didOutput state of its children
 @returns `YES` if it still requires output
 */
- (BOOL)needsOutput;

@end
