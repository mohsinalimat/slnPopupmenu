//
//  PopupView.h
//  Popupwindow
//
//  Created by Puvanarajan on 12/22/16.
//  Copyright © 2016 Puvanarajan. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 PopupMenu Success block§

 @param selectedIndex return selected memu index
 */
typedef void (^PopupMenuSuccesBlock)(NSInteger selectedIndex);

/**
 Popupmenu dismiss block
 */
typedef void (^PopupMenuDismissBlock)();

/**
 Create the popup view
 */
@interface PopupView : UIView <UIGestureRecognizerDelegate>


/**
 Popup the menu with menu title, menu icon and menu descrptiom
 
 @param menu Menu array with title, Image and description
 @param fontFamilyName Menu title and menu description font family (Optional)
 @param touchPoint set the menu popup touch points
 */
+ (void)showPopWithDescriptionImage:(NSArray *)menu
                               font:(NSString *)fontFamilyName
                         touchPoint:(CGPoint)touchPoint
                            success:(PopupMenuSuccesBlock)success
                            dismiss:(PopupMenuDismissBlock)dismiss;


/**
 Popup menu with only description
 
 @param menu Menu array with title, description
 @param fontFamilyName Menu title and description font family (Optional)
 @param touchPoint set the menu popup touch points
 */
+ (void)showPopOnlyWithTitleAndDescription:(NSArray *)menu
                                      font:(NSString *)fontFamilyName
                                touchPoint:(CGPoint)touchPoint
                                    success:(PopupMenuSuccesBlock)success
                                   dismiss:(PopupMenuDismissBlock)dismiss;


/**
 Popup the menu with menu title and menu icon

 @param menu Menu array with title and image
 @param fontFamilyName Menu title font family (Optional)
 @param touchPoint set the menu popup touch points
 */
+ (void)showPopOnlyWithTitleAndImage:(NSArray *)menu
                                font:(NSString *)fontFamilyName
                          touchPoint:(CGPoint)touchPoint
                             success:(PopupMenuSuccesBlock)success
                             dismiss:(PopupMenuDismissBlock)dismiss;

@property (nonatomic, strong) PopupMenuDismissBlock popupDismissBlock;

@end

@interface PopupMenu : NSObject

@property (nonatomic, strong) NSString *menuTitle;
@property (nonatomic, strong) NSString *menuSubtitle;
@property (nonatomic, strong) UIImage *menuIcon;

@end

@interface PopupTableViewCell: UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                         font:(UIFont *)font
                    tableView:(UITableView *)tableview
                 isDescrption:(BOOL)isDescription
                      isImage:(BOOL)isImage;

- (void)setMenu:(PopupMenu *)popupmenu;
@end

@interface PopupViewContrller : UIControl <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame
                     menuItem:(NSArray *)menu
                         font:(UIFont *)font
                 isDescrption:(BOOL)isDescription
                      isImage:(BOOL)isImage;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic) CGFloat tableHeight;
@property (nonatomic, strong) PopupMenuSuccesBlock popupSuccessBlock;

@end
