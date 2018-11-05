//
//  AppDelegate+ViewModel.m
//  MVVM+Routes
//
//  Created by yihua on 2018/11/1.
//  Copyright © 2018年 yihua. All rights reserved.
//

#import "AppDelegate+ViewModel.h"
#import "UIViewController+NonBase.h"
#import "JLRRouteHandler.h"

@implementation AppDelegate (ViewModel)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    
    return [JLRoutes routeURL:url];
}
@end

#pragma mark - 路由注册
@implementation AppDelegate(RouterRegister)

#pragma mark - 普通的跳转路由注册
- (void)registerNavgationRouter
{
    JLRoutes *routes = [JLRoutes routesForScheme:@"/test/view/:userID"];
    [routes addRoute:@"/test/view/:userID" handler:^BOOL(NSDictionary *parameters) {
        TestIngViewController *viewController = [[TestIngViewController alloc] init];
        [[self _currentViewController] presentViewController:viewController animated:NO completion:nil];
        // present UI for viewing user with ID 'userID'
        
        return YES; // return YES to say we have handled the route
    }];
    
    // push
    // 路由 /com_madao_navPush/:viewController
    [[JLRoutes globalRoutes] addRoute:FKNavPushRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _handlerSceneWithPresent:NO parameters:parameters];
            
        });
        return YES;
    }];
    
    // present
    // 路由 /com_madao_navPresent/:viewController
    [[JLRoutes globalRoutes] addRoute:FKNavPresentRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _handlerSceneWithPresent:YES parameters:parameters];
            
        });
        return YES;
    }];
    
    // sb push
    // 路由 /com_madao_navStoryboardPush/:viewController
    [[JLRoutes globalRoutes] addRoute:FKNavStoryBoardPushRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        return YES;
    }];
    
}

#pragma mark - Schema 匹配
- (void)registerSchemaRouter
{
    // HTTP注册
    [[JLRoutes routesForScheme:FKHTTPRouteSchema] addRoute:@"/somethingHTTP" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        return NO;
    }];
    
    // HTTPS注册
    [[JLRoutes routesForScheme:FKHTTPsRouteSchema] addRoute:@"/somethingHTTPs" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return NO;
        
    }];
    
    // 自定义 Schema注册
    [[JLRoutes routesForScheme:FKWebHandlerRouteSchema] addRoute:@"/somethingCustom" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return NO;
        
    }];
}

#pragma mark - Private
/// 处理跳转事件
- (void)_handlerSceneWithPresent:(BOOL)isPresent parameters:(NSDictionary *)parameters
{
    // 当前控制器
    NSString *controllerName = [parameters objectForKey:FKControllerNameRouteParam];
    UIViewController *currentVC = [self _currentViewController];
    UIViewController *toVC = [[NSClassFromString(controllerName) alloc] init];
    toVC.params = parameters;
    if (currentVC && currentVC.navigationController) {
        if (isPresent) {
            [currentVC.navigationController presentViewController:toVC animated:YES completion:nil];
        }else
        {
            [currentVC.navigationController pushViewController:toVC animated:YES];
        }
    }
}

/// 获取当前控制器
- (UIViewController *)_currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}




@end
