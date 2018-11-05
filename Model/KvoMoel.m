//
//  KvoMoel.m
//  MVVM+Routes
//
//  Created by yihua on 2018/11/2.
//  Copyright © 2018年 yihua. All rights reserved.
//

#import "KvoMoel.h"

@implementation KvoMoel
{
    RACSignal *rac;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initializeForViewModel];
    }
    return self;
}
/**
 viewModel 初始化属性
 */
- (void)initializeForViewModel
{
//    // 是否可以登录  布尔接受后才会开启
   RAC(self,isChange) = [[RACSignal combineLatest:@[RACObserve(self, nameStr),RACObserve(self, count)]]
             map:^id _Nullable(RACTuple * _Nullable value) {
                 RACTupleUnpack(NSString *account, NSNumber *pwd) = value;
                 NSLog(@"%@ %@",account,pwd);

                 return @(account && pwd && account.length && pwd);
                 
             }];
    //订阅后才会开启
    [[[RACSignal combineLatest:@[RACObserve(self, nameStr),RACObserve(self, count)]]
      map:^id _Nullable(RACTuple * _Nullable value) {
          RACTupleUnpack(NSString *account, NSNumber *pwd) = value;
          NSLog(@"%@ %@",account,pwd);
          
          return @(account && pwd && account.length && pwd);
          
      }] subscribeNext:^(id  _Nullable x) {
          NSLog(@"%@",x);
      }];
    
}
@end
