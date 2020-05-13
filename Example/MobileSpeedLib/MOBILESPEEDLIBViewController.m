//
//  MOBILESPEEDLIBViewController.m
//  MobileSpeedLib
//
//  Created by zoucheng@live.cn on 05/13/2020.
//  Copyright (c) 2020 zoucheng@live.cn. All rights reserved.
//

#import "MOBILESPEEDLIBViewController.h"
#import "MobileSpeedLib.h"

@interface MOBILESPEEDLIBViewController ()

@end

@implementation MOBILESPEEDLIBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [TestUtils sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
