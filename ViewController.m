//
//  ViewController.m
//  MVVM+Routes
//
//  Created by yihua on 2018/11/1.
//  Copyright © 2018年 yihua. All rights reserved.
//

#import "ViewController.h"
#import "KvoMoel.h"
@interface ViewController ()
@property (nonatomic,strong) KvoMoel *kvoModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 200, 200)];
    [button setBackgroundColor:[UIColor blackColor]];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
     
    
    self.kvoModel = [KvoMoel new];
    self.kvoModel.count ++;
    self.kvoModel.nameStr = @"00";
}


-(void)buttonAction:(UIButton *)sender
{
    self.kvoModel.count ++;
    self.kvoModel.nameStr = @"1230";
//    NSURL *viewUserURL = [NSURL URLWithString:@"/test/view/joeldev"];
//    [JLRoutes routeURL:viewUserURL];
    
}

@end
