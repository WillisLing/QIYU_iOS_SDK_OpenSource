#import "YSFSessionMessageContentView.h"

extern CGFloat const kYSFActionItemsMargin;
extern CGFloat const kYSFActionItemsTBMargin;
extern CGFloat const kYSFActionButtonHeight;

@interface YSFStaticUnionContentView : YSFSessionMessageContentView

@property (nonatomic, strong, readonly) NSArray<UIImageView *> *imageViewsArray;

@end
