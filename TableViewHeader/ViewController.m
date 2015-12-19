//
//  ViewController.m
//  TableViewHeader
//
//  Created by Alex on 15/12/19.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "TypeCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *salesContentView;
@property (weak, nonatomic) IBOutlet UIImageView *salesSelectedIndicatorImgView;
@property (weak, nonatomic) IBOutlet UIImageView *salesTypeImgView;
@property (weak, nonatomic) IBOutlet UILabel *salesTypeLbl;
@property (weak, nonatomic) IBOutlet UIButton *salesTypeBtn;
@property (weak, nonatomic) IBOutlet UIView *salesView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *salesViewHConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _salesTypeLbl.text = @"特惠";
    
    // 不设置UIview clipsToBounds 属性 UIimageView不会被影藏
    _salesView.clipsToBounds = YES;
    [self showOrHideSalesView:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentinfier = @"TypeCell";
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentinfier forIndexPath:indexPath];
    
    cell.typeLbl.text = [NSString stringWithFormat:@"Type-%ld",indexPath.row];
    cell.typeImgView.image = [UIImage imageNamed:@"type_test_n"];
    cell.typeImgView.highlightedImage = [UIImage imageNamed:@"type_test_s"];
    
    UIView *selectView = [UIView new];
    selectView.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = selectView;
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"type_Selected_Indicator"];
    imgView .frame = CGRectMake(0, 0, 2, 69);
    [selectView addSubview:imgView];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _salesTypeBtn.selected = NO;
    [self salesTypeViewWithSelected:NO];
    
    [self requestTypeData:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69.;
}

- (IBAction)salesBtnClicked:(UIButton *)sender {
    
    if (sender.selected) {
        return;
    }
    
    sender.selected = !sender.selected;
    [self salesTypeViewWithSelected:sender.selected];
    
    [self cancelTableViewDeselectRow];
}

#pragma mark -
#pragma mark - 是否显示特惠专区
- (void)showOrHideSalesView:(BOOL)yesOrNo
{
    if (yesOrNo) {
        _salesViewHConstraint.constant = 0.;
        
        [self requestTypeData:0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        });
    }
    else{
        _salesViewHConstraint.constant = 69.;
        
        [self salesTypeViewWithSelected:YES];
    }
}

#pragma mark -
#pragma mark - 设置特惠View选中或取消状态
- (void)salesTypeViewWithSelected:(BOOL)selected
{
    if (selected) {
        _salesContentView.backgroundColor = [UIColor whiteColor];
        _salesSelectedIndicatorImgView.hidden = NO;
        _salesTypeImgView.highlighted = YES;
        
        [self requestSalesData];
        
    }
    else{
        _salesContentView.backgroundColor = [UIColor grayColor];
        _salesSelectedIndicatorImgView.hidden = YES;
        _salesTypeImgView.highlighted = NO;
    }
}

#pragma mark - 
#pragma mark - 取消Tableview 选中状态
- (void)cancelTableViewDeselectRow
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];

}

#pragma mark -
#pragma mark - 请求特惠商品数据
- (void)requestSalesData
{
    NSLog(@"请求特惠商品数据");
}

- (void)requestTypeData:(NSInteger)type
{
    NSLog(@"请求种类%ld商品",type);
}

@end
