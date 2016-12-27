//
//  PopupView.m
//  Popupwindow
//
//  Created by Puvanarajan on 12/22/16.
//  Copyright © 2016 Puvanarajan. All rights reserved.
//

#import "PopupView.h"

#define CONSTANT_MAIN_VIEW_LEFT_MINIMUM 12
#define CONSTANT_MAIN_VIEW_LEFT_PADDING 10
#define CONSTANT_TRIANGLE_HEIGHT 12
#define CONSTANT_TRIANGLE_WIDTH 12
#define CONSTANT_TABLEVIEW_BOTTOM_PADDING 16
#define CONSTANT_IMAGEVIEW_WIDTH 30
#define CONSTANT_IMAGEVIEW_HEIGHT 30

#pragma mark - Popup view implementation

@implementation PopupView{
    
    UIView *backgroundView;
    NSMutableArray *menuArray;
    UIFont *font;
    CGPoint point;
    CGFloat tableHeight;
    UIBezierPath *path;
    BOOL isTriangleOposite;
}

+ (PopupView *)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)showPopWithDescriptionImage:(NSArray *)menu
                               font:(NSString *)fontFamilyName
                         touchPoint:(CGPoint)touchPoint
                            success:(PopupMenuSuccesBlock)success
                            dismiss:(PopupMenuDismissBlock)dismiss {
    
    [[PopupView sharedInstance] makeMenu:menu
                                    font:[UIFont fontWithName:fontFamilyName size:1]
                              touchPoint:touchPoint];
    
    [[PopupView sharedInstance] addBackgroundisDescrption:YES
                                                  isImage:YES
                                                  success:success
                                                  dismiss:dismiss];
}

+ (void)showPopOnlyWithTitleAndDescription:(NSArray *)menu
                                      font:(NSString *)fontFamilyName
                                touchPoint:(CGPoint)touchPoint
                                   success:(PopupMenuSuccesBlock)success
                                   dismiss:(PopupMenuDismissBlock)dismiss {
    
    [[PopupView sharedInstance] makeMenuDescrption:menu
                                              font:[UIFont fontWithName:fontFamilyName size:1]
                                        touchPoint:touchPoint];
    
    [[PopupView sharedInstance] addBackgroundisDescrption:YES
                                                  isImage:NO
                                                  success:success
                                                  dismiss:dismiss];
}

+ (void)showPopOnlyWithTitleAndImage:(NSArray *)menu
                                font:(NSString *)fontFamilyName
                          touchPoint:(CGPoint)touchPoint
                             success:(PopupMenuSuccesBlock)success
                             dismiss:(PopupMenuDismissBlock)dismiss {
    
    [[PopupView sharedInstance] makeMenuImage:menu
                                         font:[UIFont fontWithName:fontFamilyName size:1]
                                   touchPoint:touchPoint];
    
    [[PopupView sharedInstance] addBackgroundisDescrption:NO
                                                  isImage:YES
                                                  success:success
                                                  dismiss:dismiss];
}

- (void)makeMenu:(NSArray *)array
            font:(UIFont *)fontm
      touchPoint:(CGPoint )touchPoint {
    
    menuArray = [[NSMutableArray alloc] init];
    font = fontm;
    point = touchPoint;
    
    for (NSArray *temMenuDict in array) {
        
        PopupMenu *pm = [[PopupMenu alloc] init];
        pm.menuTitle = [temMenuDict objectAtIndex:0];
        pm.menuSubtitle = [temMenuDict objectAtIndex:1];
        pm.menuIcon = [temMenuDict objectAtIndex:2];
        
        [menuArray addObject:pm];
    }
}

- (void)makeMenuDescrption:(NSArray *)array
                      font:(UIFont *)fontm
                touchPoint:(CGPoint )touchPoint {
    
    menuArray = [[NSMutableArray alloc] init];
    font = fontm;
    point = touchPoint;
    
    for (NSArray *temMenuDict in array) {
        
        PopupMenu *pm = [[PopupMenu alloc] init];
        pm.menuTitle = [temMenuDict objectAtIndex:0];
        pm.menuSubtitle = [temMenuDict objectAtIndex:1];
        
        [menuArray addObject:pm];
    }
}

- (void)makeMenuImage:(NSArray *)array
                 font:(UIFont *)fontm
           touchPoint:(CGPoint )touchPoint {
    
    menuArray = [[NSMutableArray alloc] init];
    font = fontm;
    point = touchPoint;
    
    for (NSArray *temMenuDict in array) {
        
        PopupMenu *pm = [[PopupMenu alloc] init];
        pm.menuTitle = [temMenuDict objectAtIndex:0];
        pm.menuIcon = [temMenuDict objectAtIndex:1];
        
        [menuArray addObject:pm];
    }
}

- (void)addBackgroundisDescrption:(BOOL)isDescription
                          isImage:(BOOL)isImage
                          success:(PopupMenuSuccesBlock)success
                          dismiss:(PopupMenuDismissBlock)dismiss {
    
    isTriangleOposite = NO;
    self.popupDismissBlock = dismiss;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivDismissNotification:)
                                                 name:@"popupRemoveBackground"
                                               object:nil];
    
    CGRect displayRect = [[UIScreen mainScreen] bounds];
    backgroundView = [[UIView alloc]initWithFrame:displayRect];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    singleFingerTap.delegate = self;
    [backgroundView addGestureRecognizer:singleFingerTap];
    
    tableHeight = 0;
    
    for (int i = 0; i < [menuArray count]; i ++) {
        tableHeight += 46;
    }
    
    CGFloat tt = [self yCalculation:displayRect poin:point height:tableHeight];
    
    CGFloat trix = 0;
    CGFloat triy = point.y;
    
    if (point.x <= CONSTANT_MAIN_VIEW_LEFT_MINIMUM) {
        
        trix = CONSTANT_MAIN_VIEW_LEFT_MINIMUM + 1;;
    }
    else if (point.x > displayRect.size.width - (CONSTANT_MAIN_VIEW_LEFT_PADDING*2 - CONSTANT_TRIANGLE_WIDTH)) {
        
        trix = displayRect.size.width - (CONSTANT_MAIN_VIEW_LEFT_PADDING*2 - CONSTANT_TRIANGLE_WIDTH);
    }
    else{
        
        trix = point.x;
    }
    
    if (isTriangleOposite) {
        
        triy = tt + tableHeight;
    }
    
    UIView *triView ;
    UIView *mainView;
    
    if (isTriangleOposite) {
        
        triView = [[UIView alloc] initWithFrame:CGRectMake(trix, triy-CONSTANT_MAIN_VIEW_LEFT_MINIMUM, CONSTANT_TRIANGLE_WIDTH, CONSTANT_TRIANGLE_HEIGHT)];
        triView.backgroundColor = [UIColor whiteColor];
        
        mainView = [[UIView alloc]initWithFrame:CGRectMake(CONSTANT_MAIN_VIEW_LEFT_PADDING,
                                                           tt-CONSTANT_TRIANGLE_HEIGHT,
                                                           displayRect.size.width- (CONSTANT_MAIN_VIEW_LEFT_PADDING * 2), tableHeight)];
    }
    else {
        
        triView = [[UIView alloc] initWithFrame:CGRectMake(trix, triy, CONSTANT_TRIANGLE_WIDTH, CONSTANT_TRIANGLE_HEIGHT)];
        triView.backgroundColor = [UIColor whiteColor];
        
        mainView = [[UIView alloc]initWithFrame:CGRectMake(CONSTANT_MAIN_VIEW_LEFT_PADDING,
                                                           tt+triView.frame.size.height,
                                                           displayRect.size.width- (CONSTANT_MAIN_VIEW_LEFT_PADDING * 2), tableHeight)];
    }
    
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5;
    mainView.layer.masksToBounds = YES;
    
    [backgroundView addSubview:triView];
    [backgroundView addSubview:mainView];
    
    if (isTriangleOposite) {
        path = [UIBezierPath new];
        [path moveToPoint:(CGPoint){0, 0}];
        [path addLineToPoint:(CGPoint){triView.frame.size.width, 0}];
        [path addLineToPoint:(CGPoint){triView.frame.size.width/2, triView.frame.size.height}];
        [path addLineToPoint:(CGPoint){triView.frame.size.width/2, triView.frame.size.height}];
    }
    else {
        path = [UIBezierPath new];
        [path moveToPoint:(CGPoint){triView.frame.size.width/2, 0}];
        [path addLineToPoint:(CGPoint){triView.frame.size.width/2, 0}];
        [path addLineToPoint:(CGPoint){0, triView.frame.size.height}];
        [path addLineToPoint:(CGPoint){triView.frame.size.height, triView.frame.size.height}];
    }
    
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = mainView.bounds;
    mask.path = path.CGPath;
    triView.layer.mask = mask;
    
    PopupViewContrller *pvc = [[PopupViewContrller alloc]initWithFrame:CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height)
                                                              menuItem:menuArray
                                                                  font:font
                                                          isDescrption:isDescription
                                                               isImage:isImage];
    pvc.popupSuccessBlock = success;
    [mainView addSubview:pvc];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:backgroundView];
}

- (void)removeBackground {
    
    self.popupDismissBlock() ;
    [backgroundView removeFromSuperview];
}

- (void) receivDismissNotification:(NSNotification *) notification
{
   [backgroundView removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"popupRemoveBackground"
                                                  object:nil];

}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [[PopupView sharedInstance] removeBackground];
}

- (CGFloat)yCalculation:(CGRect)mainDisplay poin:(CGPoint)pointt height:(CGFloat)tableheight {
    
    CGFloat mainDisplayHalfHeight = mainDisplay.size.height/2;
    CGFloat tapYpoint = pointt.y;
    
    if (tapYpoint <= mainDisplayHalfHeight) {
        
        if (tableHeight > (mainDisplay.size.height - tapYpoint)) {
            tableHeight = (mainDisplay.size.height - tapYpoint - CONSTANT_TABLEVIEW_BOTTOM_PADDING - CONSTANT_TRIANGLE_HEIGHT);
        }
        return tapYpoint;
    }
    else{
        
        if ((mainDisplay.size.height-tapYpoint) > tableheight) {
            return tapYpoint;
        }
        else{
            if (tapYpoint < tableheight) {
                tableHeight = tapYpoint - CONSTANT_TABLEVIEW_BOTTOM_PADDING - CONSTANT_TRIANGLE_HEIGHT;
                isTriangleOposite = YES;
                return (tapYpoint-tableHeight - CONSTANT_TRIANGLE_HEIGHT);
            }
            else{
                isTriangleOposite = YES;
                return (tapYpoint-tableHeight);
            }
        }
    }
    return 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if (touch.view == backgroundView) {
        return YES;
    }
    else {
        return NO;
    }
}

@end

#pragma mark - Popup viewcontroller implemenatation

@implementation PopupViewContrller{
    
    UITableView *tblMenu;
    NSArray *menuArray;
    BOOL isDescriptionSet;
    BOOL isImageSet;
}

- (instancetype)initWithFrame:(CGRect)frame
                     menuItem:(NSArray *)menu
                         font:(UIFont *)font
                 isDescrption:(BOOL)isDescription
                      isImage:(BOOL)isImage
{
    self = [super initWithFrame:frame];
    if (self) {
        menuArray = menu;
        self.font = font;
        isDescriptionSet = isDescription;
        isImageSet = isImage;
        
        [self menuTableView];
        
        self.tableHeight = 0.0f;
        for (int i = 0; i < [menuArray count]; i ++) {
            self.tableHeight += [self tableView:tblMenu heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    return self;
}

- (UITableView *)menuTableView
{
    if (!tblMenu) {
        tblMenu = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        tblMenu.separatorColor = [UIColor grayColor];
        tblMenu.scrollEnabled = YES;
        tblMenu.clipsToBounds = YES;
        tblMenu.delegate = self;
        tblMenu.dataSource = self;
        [self addSubview:tblMenu];
    }
    return tblMenu;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PopupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    PopupMenu *pp = [menuArray objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[PopupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:@"cell"
                                                    font:self.font
                                               tableView:tableView
                                            isDescrption:isDescriptionSet
                                                 isImage:isImageSet];
    }
    
    [cell setMenu:pp];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.popupSuccessBlock) {
        self.popupSuccessBlock(indexPath.row);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"popupRemoveBackground" object:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 46;
}

@end

#pragma mark - Tableview Cell Implementation

@interface PopupTableViewCell()

@property (nonatomic, strong) UIImageView *imgMenuImageView;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblSubtitle;

@end

@implementation PopupTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                         font:(UIFont *)font
                    tableView:(UITableView *)tableview
                 isDescrption:(BOOL)isDescription
                      isImage:(BOOL)isImage{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (isImage) {
            if (!self.imgMenuImageView) {
                
                self.imgMenuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, CONSTANT_IMAGEVIEW_WIDTH, CONSTANT_IMAGEVIEW_HEIGHT)];
                self.imgMenuImageView.backgroundColor = [UIColor clearColor];
                self.imgMenuImageView.contentMode = UIViewContentModeScaleAspectFit;
            }
            
            [self.contentView addSubview:self.imgMenuImageView];
        }
        
        if (!self.lblTitle) {
            
            self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(isImage ? self.imgMenuImageView.frame.origin.x + self.imgMenuImageView.frame.size.width+8 : 8, 8,
                                                                      tableview.frame.size.width - self.imgMenuImageView.frame.size.width - 24,
                                                                      isDescription ? 21 : CONSTANT_IMAGEVIEW_HEIGHT)];
            self.lblTitle.backgroundColor = [UIColor clearColor];
            
            if (font) {
                
                [self.lblTitle setFont:font];;
            }
            
            self.lblTitle.font = [self.lblTitle.font fontWithSize:17];
        }
        
        [self.contentView addSubview:self.lblTitle];
        
        if (isDescription) {
            if (!self.lblSubtitle) {
                
                self.lblSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(isDescription ? self.imgMenuImageView.frame.origin.x + self.imgMenuImageView.frame.size.width+8 : 8,
                                                                             self.lblTitle.frame.origin.y+self.lblTitle.frame.size.height,
                                                                             tableview.frame.size.width - self.imgMenuImageView.frame.size.width - 24, 17)];
                self.lblSubtitle.text = @"Description";
                self.lblSubtitle.backgroundColor = [UIColor clearColor];
                
                if (font) {
                    
                    [self.lblSubtitle setFont:font];;
                }
                
                self.lblSubtitle.font = [self.lblSubtitle.font fontWithSize:10];
            }
            
            [self.contentView addSubview:self.lblSubtitle];
        }
    }
    
    return self;
}

- (void)setMenu:(PopupMenu *)popupmenu{
    
    self.lblTitle.text = popupmenu.menuTitle;
    
    if (popupmenu.menuIcon) {
        self.imgMenuImageView.image = popupmenu.menuIcon;
    }
    else{
        
        CGRect temFrame = self.imgMenuImageView.frame;
        temFrame.size.width = 0;
        [self.imgMenuImageView setFrame:temFrame];
    }
    
    if (popupmenu.menuSubtitle) {
        self.lblSubtitle.text = popupmenu.menuSubtitle;
    }
    else{
        
        CGRect temFrame = self.imgMenuImageView.frame;
        temFrame.size.width = 0;
        [self.lblSubtitle setFrame:temFrame];
    }
    
}
@end

@implementation PopupMenu

@end
