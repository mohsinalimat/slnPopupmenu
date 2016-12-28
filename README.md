Welcome to SLNPopupMenu!
=======================

SLNPopupMenu is iOS simple class library for create the popup menu

***Import file***
Method 01: 

> 1. Drag and drop the SLNPopupMenu folder (`popupview.h` and `popuview.m`)
> 
> 2. Import the file where you want 
> `#import "PopupView.h"` 

Method 2:  Using pod 

> `pod 'SLNPopupMenu'`
> `#import "PopupView.h"`

How to use

 1. Menu with Title, Description and Menu Icon

![enter image description here](https://raw.githubusercontent.com/puvanarajan/slnPopupmenu/master/1.png)


    NSArray *menu = @[
    @["Title 1", "Description", [UIImage ImageWithName:@"img1.png"]],
    @["Title 2", "Description", [UIImage ImageWithName:@"img2.png"]],
    @["Title 3", "Description", [UIImage ImageWithName:@"img3.png"]],
    @["Title 4", "Description", [UIImage ImageWithName:@"img4.png"]]
    ]

   

    [PopupView showPopWithDescriptionImage:menu font:nil touchPoint:[recognizer locationInView:self.view] success:^(NSInteger selectedIndex) {
                NSLog(@"Selected Index %li", (long)selectedIndex);
            } dismiss:^{
                NSLog(@"Disissed");
            }];

 

 
 
 2. Menu with Title and Description

![enter image description here](https://raw.githubusercontent.com/puvanarajan/slnPopupmenu/master/2.png)

    NSArray *menu = @[
        @["Title 1", "Description"],
        @["Title 2", "Description"],
        @["Title 3", "Description"],
        @["Title 4", "Description"]
        ]
    

    [PopupView showPopOnlyWithTitleAndDescription:menu font:nil touchPoint:[recognizer locationInView:self.view] success:^(NSInteger selectedIndex) {
                NSLog(@"Selected Index %li", (long)selectedIndex);
            } dismiss:^{
                NSLog(@"Disissed");
            }];



 3.  Menu with Title and Image
![enter image description here](https://raw.githubusercontent.com/puvanarajan/slnPopupmenu/master/3.png)

 

    NSArray *menu = @[
        @["Title 1", [UIImage ImageWithName:@"img1.png"]],
        @["Title 2", [UIImage ImageWithName:@"img2.png"]],
        @["Title 3", [UIImage ImageWithName:@"img3.png"]],
        @["Title 4", [UIImage ImageWithName:@"img4.png"]]
        ]

   

     [PopupView showPopOnlyWithTitleAndImage:menuArrayImage font:nil touchPoint:[recognizer locationInView:self.view] success:^(NSInteger selectedIndex) {
                    NSLog(@"Selected Index %li", (long)selectedIndex);
                } dismiss:^{
                    NSLog(@"Disissed");
                }];