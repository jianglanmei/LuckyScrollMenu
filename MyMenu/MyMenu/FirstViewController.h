//
//  FirstViewController.h
//  MyMenu
//
//  Created by heishaLucky on 2020/4/10.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MenuTypeAll,            // 全部
    MenuTypeWomen,          // 女装
    MenuTypeMan,            // 男装
    MenuTypeUnderwear,      // 内衣
    MenuTypeBaby,           // 母婴
    MenuTypeBeauty,         // 美妆
    MenuTypeHome,           // 居家
    MenuTypeAccessories,    // 配饰
    MenuTypeFood,           // 食品
    MenuTypeDigital,        // 数码
    MenuTypeOutdoor,        // 户外
} MenuType;

@interface FirstViewController : UIViewController
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) MenuType menuType;

+ (FirstViewController *)shareInstance;

@end

NS_ASSUME_NONNULL_END
