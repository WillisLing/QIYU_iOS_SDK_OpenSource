//
//  YSFSessionProductInfoContentView.m
//  YSFSessionViewController
//
//  Created by JackyYu on 16/5/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "YSFSessionCommodityInfoContentView.h"
#import "YSFMessageModel.h"
#import "YSFCommodityInfoShow.h"
#import "YSFWebImageManager.h"


@interface YSFSessionCommodityInfoContentView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImage *defaultImage;

@property (nonatomic, strong) UIImageView *productImageView;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UILabel *noteLabel;

@end

@implementation YSFSessionCommodityInfoContentView

- (instancetype)initSessionMessageContentView
{
    if (self = [super initSessionMessageContentView]) {
        [self setupCommodityInfoView];
    }
    
    return self;
}

- (void)setupCommodityInfoView
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.numberOfLines = 1;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.textColor = YSFRGB(0x222222);
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_titleLabel sizeToFit];
    [self addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descLabel.backgroundColor = [UIColor clearColor];
    _descLabel.numberOfLines = 2;
    _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _descLabel.textColor = YSFRGB(0x333333);
    _descLabel.font = [UIFont systemFontOfSize:13.f];
    [_descLabel sizeToFit];
    [self addSubview:_descLabel];
    
    _noteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _noteLabel.backgroundColor = [UIColor clearColor];
    _noteLabel.numberOfLines = 1;
    _noteLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _noteLabel.textColor = YSFRGB(0x333333);
    _noteLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [_noteLabel sizeToFit];
    [self addSubview:_noteLabel];
    
    _defaultImage = [UIImage ysf_imageInKit:@"icon_commodityInfo_default_picture"];
    _productImageView = [[UIImageView alloc] initWithImage:_defaultImage];
    _productImageView.backgroundColor = [UIColor clearColor];
    _productImageView.contentMode = UIViewContentModeScaleAspectFill;
    _productImageView.clipsToBounds = YES;
    [self addSubview:_productImageView];
    
}

- (void)refresh:(YSFMessageModel *)data
{
    [super refresh:data];
    
    YSF_NIMCustomObject *object = (YSF_NIMCustomObject *)data.message.messageObject;
    YSFCommodityInfoShow *attachment = (YSFCommodityInfoShow *)object.attachment;
    
    [_titleLabel setText:attachment.title];
    [_descLabel setText:attachment.desc];
    [_noteLabel setText:attachment.note];
    [_productImageView setImage:_defaultImage];

    if (attachment.pictureUrlString) {
        NSString *urlString = [attachment.pictureUrlString ysf_trim];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [self setUserAgent];
        [[YSFWebImageManager sharedManager] downloadImageWithURL:imageUrl options:YSFWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, YSFImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!error && finished) {
                self.productImageView.image = image;
                [self setNeedsLayout];
            }
        }];
    }
    
}

//有些服务器需要userAgent验证
- (void)setUserAgent
{
    NSString *userAgent = @"";
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    userAgent = [NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
    
    [[YSFWebImageDownloader sharedDownloader] setValue:userAgent forHTTPHeaderField:@"User-Agent"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIEdgeInsets contentInsets = self.model.contentViewInsets;
    CGSize contentsize = self.model.contentSize;

    _productImageView.ysf_frameLeft = 10;
    _productImageView.ysf_frameTop = 12;
    _productImageView.ysf_frameWidth = 65;
    _productImageView.ysf_frameHeight = 65;
    
    _titleLabel.hidden = YES;

    _descLabel.ysf_frameLeft = _productImageView.ysf_frameRight + 10;
    _descLabel.ysf_frameTop = 13;
    _descLabel.ysf_frameWidth = contentsize.width - _productImageView.ysf_frameWidth - 12;
    _descLabel.ysf_frameHeight = [_descLabel sizeThatFits:CGSizeMake(contentsize.width, _descLabel.ysf_frameWidth)].height;
    
    _noteLabel.ysf_frameLeft = _productImageView.ysf_frameRight + 10;
    _noteLabel.ysf_frameTop = contentsize.height - 13 - _noteLabel.font.lineHeight;
    _noteLabel.ysf_frameWidth = contentsize.width - _productImageView.ysf_frameWidth - 12;
    _noteLabel.ysf_frameHeight = _noteLabel.font.lineHeight;
}

- (void)onTouchUpInside:(id)sender
{
    YSFKitEvent *event = [[YSFKitEvent alloc] init];
    event.eventName = YSFKitEventNameTapCommodityInfo;
    event.message = self.model.message;
    [self.delegate onCatchEvent:event];
}

#pragma mark - Private 
//override
//商品信息展示需要显示白色底
- (UIImage *)chatNormalBubbleImage
{
    UIImage *customerNormalImage = [[UIImage ysf_imageInKit:@"icon_sender_commodityInfo_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    UIImage *serviceNormalImage = [[UIImage ysf_imageInKit:@"icon_receiver_commodityInfo_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    
    return self.model.message.isOutgoingMsg ? customerNormalImage : serviceNormalImage;
}

//override
//商品信息展示需要显示白色底
- (UIImage *)chatHighlightedBubbleImage
{
    UIImage *customerNormalImage = [[UIImage ysf_imageInKit:@"icon_sender_commodityInfo_pressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    UIImage *serviceNormalImage = [[UIImage ysf_imageInKit:@"icon_receiver_commodityInfo_pressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    
    return self.model.message.isOutgoingMsg ? customerNormalImage : serviceNormalImage;
}




@end
