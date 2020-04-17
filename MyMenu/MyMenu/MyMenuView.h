//
//  MyMenuView.h
//  MyMenu
//
//  Created by heishaLucky on 2020/4/10.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MyMenuViewDelegate <NSObject>

- (void)selectItem:(NSInteger)index;

@end

@interface MyMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray<NSString *> *)titleArr delegate:(id<MyMenuViewDelegate>)delegate;

- (void)shouldScrollMenuView:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
