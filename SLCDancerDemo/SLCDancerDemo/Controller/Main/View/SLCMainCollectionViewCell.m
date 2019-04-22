//
//  SLCMainCollectionViewCell.m
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/24.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "SLCMainCollectionViewCell.h"
#import "SLCMainModel.h"

@interface SLCMainCollectionViewCell()

@property (nonatomic, strong) UIView * bgShadowView;
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * detailLabel;

@end

@implementation SLCMainCollectionViewCell

+ (CGSize)itemSize
{
    return CGSizeMake(SCREEN_WIDTH - 20 * 2, 180);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.masksToBounds = NO;
        self.contentView.layer.masksToBounds = NO;
        
        [self.contentView addSubview:self.bgShadowView];
        [self.contentView addSubview:self.bgImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        
        [self.bgShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(20);
            make.trailing.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.detailLabel.mas_top).offset(-5);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(20);
            make.trailing.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
    }
    return self;
}

- (void)setModel:(SLCMainModel *)model
{
    _model = model;
    
    self.bgImageView.image = [UIImage imageNamed:model.bgImage];
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.detail;
}

- (UIView *)bgShadowView
{
    if (!_bgShadowView)
    {
        _bgShadowView = [[UIView alloc] init];
        _bgShadowView.backgroundColor = UIColor.whiteColor;
        _bgShadowView.shadow = SLCShadowMake(CGSizeMake(0, 8), 24, 0.3, 0x000000, 12);
    }
    return _bgShadowView;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.layer.cornerRadius = 12;
        _bgImageView.layer.masksToBounds = YES;
    }
    return _bgImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
        _titleLabel.textColor = UIColor.whiteColor;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textColor = UIColor.whiteColor;
    }
    return _detailLabel;
}

@end
