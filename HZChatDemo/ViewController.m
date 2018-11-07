//
//  ViewController.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "ViewController.h"
#import "HZChatViewController.h"
#import "OpenUDID.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)buttonClicked:(id)sender {
    
    NSLog(@"--%@",[OpenUDID value]);
//    
//    return;
    HZChatViewController *vc = [HZChatViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
