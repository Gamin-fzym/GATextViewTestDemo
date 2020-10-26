//
//  BLogInputTextCell.m
//  甲丁
//
//  Created by Gamin on 6/10/20.
//  Copyright © 2020 www.hidui.com. All rights reserved.
//

#import "BLogInputTextCell.h"
#import "MBProgressHUD+MJ.h"
#import "CALayer+XibBorderColor.h"

@implementation BLogInputTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _inputTextView.placeholderColor = [UIColor colorWithRed:200/255.0 green:203/255.0 blue:212/255.0 alpha:1];
    _inputTextView.delegate = self;
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString * ID = NSStringFromClass([self class]);
    BLogInputTextCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)releaseAction {
    _alertHConstraint.constant = 0.0;
    float w = [UIScreen mainScreen].bounds.size.width - 15*2;
    _textWConstraint.constant = w;
    _inputTextView.userInteractionEnabled = NO;
}

- (void)initWithObject:(id)object IndexPath:(NSIndexPath *)indexPath {
    [self releaseAction];
    if (object) {
        _dataModel = object;
        _inputTextView.placeholder = _dataModel.placeText;
        _inputTextView.text = _dataModel.inputText;
        [self textViewDidChange:_inputTextView];
        _alertLab.text = [NSString stringWithFormat:@"%lu/%ld字",(unsigned long)_inputTextView.text.length,(long)_dataModel.limitNum];
        
        if (_isCanEdit) {
            _alertHConstraint.constant = 24.0;
            _inputTextView.userInteractionEnabled = YES;
        }
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _inputTextView.placeholder = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _dataModel.inputText = textView.text;
    [self changePlaceholder];
}

- (void)changePlaceholder {
    if (_inputTextView.text.length > 0) {
        _inputTextView.placeholder = @"";
    } else {
        _inputTextView.placeholder = _dataModel.placeText;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    [self updateTextViewHeight];
}

- (void)updateTextViewHeight {
    CGSize size = _inputTextView.contentSize;
    
    float h = 0;
    if (size.height > 54) {
        h = size.height;
    } else {
        h = 54;
    }
    _textHConstraint.constant = h;

    if (_dataModel.textHeight == h) {

    } else {
        _dataModel.textHeight = h;
        // 让 table view 重新计算高度
        UITableView *tableView = [self tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

- (void)sss {
    
}

- (UITableView *)tableView {
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

// 时时监听
- (void)infoAction:(NSNotification*)notf {
    // 限制输入字数
    [self textViewMaxTextCount:self.inputTextView AndMaxCount:_dataModel.limitNum];
}

/// UITextView字数限制
/// @param textView textView
/// @param maxCount 限制字数
- (void)textViewMaxTextCount:(UITextView *)textView AndMaxCount:(NSInteger)maxCount {
    NSString *toBeString = textView.text;
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // 中文输入
        UITextRange *selectedRange = [textView markedTextRange];
        // 获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > maxCount) {
                textView.text = [toBeString substringToIndex:maxCount];
                [MBProgressHUD showError:[NSString stringWithFormat:@"字数不能超过%ld字",(long)maxCount]];
            }
        } else {//有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    } else {//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > maxCount) {
            textView.text = [toBeString substringToIndex:maxCount];
            [MBProgressHUD showError:[NSString stringWithFormat:@"字数不能超过%ld字",(long)maxCount]];
        }
    }
    _alertLab.text = [NSString stringWithFormat:@"%lu/%ld字",(unsigned long)textView.text.length,(long)_dataModel.limitNum];
}


@end
