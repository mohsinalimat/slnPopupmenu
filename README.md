# slnPopupmenu

SLNPopupMenu is the very simplest and user friendly library. 

How to install

Method 1:
1. Download the SLNPopupMenu Folder and import to xcode project
2. #import "PopupView.h"


Method 2.

Using pods

pod 'SLNPopupMenu'


[PopupView showPopWithDescriptionImage:menuArray font:nil touchPoint:[recognizer locationInView:self.view] success:^(NSInteger selectedIndex) {
        NSLog(@"Selected Index %li", (long)selectedIndex);
    } dismiss:^{
        NSLog(@"Disissed");
    }];
