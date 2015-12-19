//
//  TypeCell.h
//  TableViewHeader
//
//  Created by Alex on 15/12/19.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *typeImgView;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UIView *cellContentView;

@end
