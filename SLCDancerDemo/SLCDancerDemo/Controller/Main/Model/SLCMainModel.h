//
//  SLCMainModel.h
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/24.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLCMainModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * detail;
@property (nonatomic, copy) NSString * bgImage;

@end

NS_ASSUME_NONNULL_END
