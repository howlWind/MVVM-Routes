//
//  KvoMoel.h
//  MVVM+Routes
//
//  Created by yihua on 2018/11/2.
//  Copyright © 2018年 yihua. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KvoMoel : NSObject

@property (nonatomic,copy) NSString *nameStr;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,assign) BOOL isChange;
- (void)initializeForViewModel;

@end

NS_ASSUME_NONNULL_END
