//
//  ViewController.m
//  SLNPopupMenu
//
//  Created by Puvanarajan on 12/27/16.
//  Copyright © 2016 Puvanarajan. All rights reserved.
//

#import "ViewController.h"
#import "PopupView.h"

@interface ViewController (){
    
    NSMutableArray *menuArray;
    NSMutableArray *menuArrayDescription;
    NSMutableArray *menuArrayImage;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuArray = [[NSMutableArray alloc] init];
    
    int i;
    for (i = 0; i < 15; i++) {
        
        NSArray *tempArray = @[[NSString stringWithFormat:@"Menu %i",i],
                               [NSString stringWithFormat:@"Test description %i", i],
                               [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", i+1]]];
        
        [menuArray addObject:tempArray];
    }
    
    
    menuArrayDescription = [[NSMutableArray alloc] init];
    
    int j;
    for (j = 0; j < 10; j++) {
        
        NSArray *tempArray = @[[NSString stringWithFormat:@"Menu %i",j],
                               [NSString stringWithFormat:@"Test description %i", j]];
        
        [menuArrayDescription addObject:tempArray];
    }
    
    menuArrayImage = [[NSMutableArray alloc] init];
    
    int k;
    for (k = 0; k < 10; k++) {
        
        NSArray *tempArray = @[[NSString stringWithFormat:@"Menu %i",k],
                               [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", k+1]]];
        
        [menuArrayImage addObject:tempArray];
    }
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [PopupView showPopWithDescriptionImage:menuArray font:nil touchPoint:[recognizer locationInView:self.view] success:^(NSInteger selectedIndex) {
        
        NSLog(@"Selected Index %li", (long)selectedIndex);
    } dismiss:^{
        NSLog(@"Disissed");
    }];
    
    //    [PopupView showPopOnlyWithTitleAndDescription:menuArrayDescription font:nil touchPoint:[recognizer locationInView:self.view]];
    
    //    [PopupView showPopOnlyWithTitleAndImage:menuArrayImage font:nil touchPoint:[recognizer locationInView:self.view]];
    
}

@end
