//
//  TRViewController.m
//  TRDrop
//
//  Created by 13036101641@163.com on 01/30/2018.
//  Copyright (c) 2018 13036101641@163.com. All rights reserved.
//

#import "TRViewController.h"
#import <TRDrop/TRDrop.h>
@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)showInfo:(id)sender {
    [TRDrop showMessage:@"我还没准备好呢" state:TRDropStateInfo duration:0.25];
}
- (IBAction)showSuccess:(id)sender {
    [TRDrop showSuccess:@"添加成功"];
}
- (IBAction)showError:(id)sender {
    [TRDrop showSuccess:@"请求失败"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
