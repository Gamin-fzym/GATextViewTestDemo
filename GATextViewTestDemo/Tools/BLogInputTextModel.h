//
//  BLogInputTextModel.h
//  甲丁
//
//  Created by Gamin on 6/10/20.
//  Copyright © 2020 www.hidui.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLogInputTextModel : NSObject

@property (nonatomic ,strong) NSString *inputText;
@property (nonatomic ,assign) NSInteger limitNum; // 限制字数
@property (nonatomic ,strong) NSString *placeText; // 默认提示文字
@property (nonatomic ,strong) NSString *mark;
@property (nonatomic ,assign) float textHeight;

@end

NS_ASSUME_NONNULL_END
