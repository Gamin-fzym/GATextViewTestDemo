//
//  JDPlaceHolderTextView.h
//  甲丁
//
//  Created by Gamin on 2019/7/18.
//  Copyright © 2019 www.hidui.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDPlaceHolderTextView : UITextView

/** 占位文字 */
@property (nonatomic, strong) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end

NS_ASSUME_NONNULL_END
