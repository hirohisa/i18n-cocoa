//
//  ViewController.m
//  iOSProject
//
//  Created by Hirohisa Kawasaki on 2015/01/29.
//  Copyright (c) 2015年 Hirohisa Kawasaki. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *string = NSLocalizedString(@"test", nil);
    string = [NSString stringWithFormat:NSLocalizedString(@"test_format", nil), NSLocalizedString(@"test", nil)];

    NSLog(@"string %@", string);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
