//
//  BLogInputTextCell.h
//  甲丁
//
//  Created by Gamin on 6/10/20.
//  Copyright © 2020 www.hidui.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLogInputTextModel.h"
#import "JDPlaceHolderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BLogInputTextCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet JDPlaceHolderTextView *inputTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHConstraint;
@property (weak, nonatomic) IBOutlet UILabel *alertLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertHConstraint;
@property (weak, nonatomic) BLogInputTextModel *dataModel;
@property (assign, nonatomic) BOOL isCanEdit; // 是否能编辑

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)initWithObject:(id)object IndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
