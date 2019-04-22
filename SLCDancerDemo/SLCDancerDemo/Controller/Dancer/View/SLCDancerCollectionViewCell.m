//
//  SLCDancerCollectionViewCell.m
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "SLCDancerCollectionViewCell.h"

@interface SLCDancerCollectionViewCell()

@property (nonatomic, strong) UIView * testView;
@property (nonatomic, strong) UIImageView * contenImageView;

@property (nonatomic, strong) UIBezierPath * bezierPath;
@property (nonatomic, strong) CAShapeLayer * shapeLayer;

@end

@implementation SLCDancerCollectionViewCell

+ (CGSize)itemSize
{
    return CGSizeMake(floor((SCREEN_WIDTH - 20 * 2 - 10 * 2) / 3), floor((SCREEN_WIDTH - 20 * 2 - 10 * 2)) / 3);
}

+ (CGSize)itemSizePlus
{
    return CGSizeMake(SCREEN_WIDTH - 20 * 2, SCREEN_WIDTH - 20 * 2);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.layer.borderColor = [UIColor.blackColor colorWithAlphaComponent:0.5].CGColor;
        self.contentView.layer.borderWidth = 2;
        
        [self.contentView addSubview:self.testView];
        [self.contentView addSubview:self.contenImageView];
        
        [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self.contenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.testView);
        }];
        
        [self.contentView.layer addSublayer:self.shapeLayer];
        
    }
    return self;
}


- (void)didMoveToSuperview
{
    switch (_dancer)
    {
        case SLCDancerMakeSize:
        {
            self.testView.makeSize(CGSizeMake(80, 80)).repeat(SLCDancerMax).reverses(YES).animate(1);

        }
            break;
        case SLCDancerMakePosition:
        {
            self.testView.makePosition(CGPointMake(25, 25)).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeX:
        {
            self.testView.makeX(80).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeY:
        {
            self.testView.makeY(80).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeWidth:
        {
            self.testView.makeWidth(80).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeHeight:
        {
            self.testView.makeHeight(80).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeScale:
        {
            self.testView.makeScale(0.5).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeScaleX:
        {
            self.testView.makeScaleX(0.5).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeScaleY:
        {
           self.testView.makeScaleY(0.5).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeRotationX:
        {
            self.testView.makeRotationX(M_PI_2).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeRotationY:
        {
            self.testView.makeRotationY(M_PI_2).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeRotationZ:
        {
            self.testView.makeRotationZ(M_PI_2).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeBackground:
        {
            self.testView.makeBackground(UIColor.blueColor).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeOpacity:
        {
            self.testView.makeOpacity(0.2).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeCornerRadius:
        {
            self.testView.makeCornerRadius(8).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMakeBorderWidth:
        {
            self.testView.makeBorderWidth(5).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
            
            
            
        case SLCDancerTakeFrame:
        {
            self.testView.takeFrame(CGRectMake(20, 20, 30, 30)).reverses(YES).animate(1);
        }
            break;
       case SLCDancerTakeLeading:
        {
            self.testView.takeLeading(0).reverses(YES).animate(1);
        }
            break;
        case SLCDancerTakeTraing:
        {
            self.testView.takeTraing(50).reverses(YES).animate(1);
        }
            break;
        case SLCDancerTakeTop:
        {
            self.testView.takeTop(0).reverses(YES).animate(1);
        }
            break;
        case SLCDancerTakeBottom:
        {
            self.testView.takeBottom(50).reverses(YES).animate(1);
        }
            break;
        case SLCDancerTakeWidth:
        {
            self.testView.takeWidth(80).reverses(YES).animate(1);
        }
            break;
        case SLCDancerTakeHeight:
        {
            self.testView.takeHeight(80).reverses(YES).animate(1);
        }
            break;
        case SLCDancerTakeSize:
        {
            self.testView.takeSize(CGSizeMake(80, 80)).reverses(YES).animate(1);
        }
            break;
            
          
        case SLCDancerMoveX:
        {
            self.testView.moveX(-20).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMoveY:
        {
            self.testView.moveY(-20).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMoveXY:
        {
            self.testView.moveXY(CGPointMake(-20, -20)).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMoveWidth:
        {
            self.testView.moveWidth(-20).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMoveHeight:
        {
           self.testView.moveHeight(-20).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
        case SLCDancerMoveSize:
        {
            self.testView.moveSize(CGSizeMake(-20, -20)).repeat(SLCDancerMax).reverses(YES).animate(1);
        }
            break;
            
            
        case SLCDancerAddLeading:
        {
            self.testView.addLeading(-20).reverses(YES).animate(1);
        }
            break;
        case SLCDancerAddTraing:
        {
            self.testView.addTraing(-20).reverses(YES).animate(1);
        }
            break;
        case SLCDancerAddTop:
        {
            self.testView.addTop(-20).reverses(YES).animate(1);
        }
            break;
        case SLCDancerAddBottom:
        {
            self.testView.addBottom(-20).reverses(YES).animate(1);
        }
            break;
        case SLCDancerAddWidth:
        {
            self.testView.addWidth(-20).reverses(YES).animate(1);
        }
            break;
        case SLCDancerAddHeight:
        {
            self.testView.addHeight(-20).reverses(YES).animate(1);
        }
            break;
        case SLCDancerAddSize:
        {
            self.testView.addSize(CGSizeMake(-20, -20)).reverses(YES).animate(1);
        }
            break;
            
            
        case SLCDancerPath:
        {
            self.testView.path(self.bezierPath).repeat(SLCDancerMax).reverses(YES).animate(1);
            self.shapeLayer.hidden = NO;
        }
            break;
        default:
            break;
    }
}


- (UIView *)testView
{
    if (!_testView)
    {
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = UIColor.redColor;
    }
    return _testView;
}

- (UIImageView *)contenImageView
{
    if (!_contenImageView)
    {
        _contenImageView = [[UIImageView alloc] init];
        _contenImageView.contentMode = UIViewContentModeScaleAspectFill;
        _contenImageView.layer.masksToBounds = YES;
        _contenImageView.hidden = YES;
    }
    return _contenImageView;
}

- (UIBezierPath *)bezierPath
{
    if (!_bezierPath)
    {
        _bezierPath = [UIBezierPath bezierPath];
        [_bezierPath moveToPoint:CGPointMake(0, 0)];
        [_bezierPath addLineToPoint:CGPointMake(80, 100)];
        [_bezierPath addLineToPoint:CGPointMake(150, 0)];
        [_bezierPath addLineToPoint:CGPointMake(300, 200)];
        [_bezierPath closePath];
    }
    return _bezierPath;
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer)
    {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = UIColor.greenColor.CGColor;
        _shapeLayer.lineWidth = 2;
        _shapeLayer.path = self.bezierPath.CGPath;
        _shapeLayer.hidden = YES;
        _shapeLayer.fillColor = UIColor.clearColor.CGColor;
    }
    return _shapeLayer;
}

@end
