//
//  HomeViewController.m
//  GATextViewTestDemo
//
//  Created by Gamin on 10/26/20.
//  Copyright © 2020 MJKJ. All rights reserved.
//

#import "HomeViewController.h"
#import "BLogInputTextCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray * dataArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cell随着输入文字的换行自动增高";
    
    BLogInputTextModel *inputModel = [BLogInputTextModel new];
    inputModel.mark = @"sgzl";
    inputModel.limitNum = 200;
    inputModel.placeText = @"请填写，限制200字以内";
    inputModel.inputText = @"";
    self.dataArr = [[NSMutableArray alloc] initWithObjects:inputModel, nil];
    [self.tableView setSeparatorStyle:NO];
    [self.tableView reloadData];
}

#pragma mark --- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLogInputTextCell *cell = [BLogInputTextCell cellWithTableView:tableView];
    cell.isCanEdit = YES;
    [cell initWithObject:self.dataArr[indexPath.row] IndexPath:indexPath];
    return cell;
}

@end
