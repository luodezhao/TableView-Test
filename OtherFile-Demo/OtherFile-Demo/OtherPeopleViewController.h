//
//  OtherPeopleViewController.h
//  
//
//  Created by 罗德昭 on 15/7/24.
//
//

#import <UIKit/UIKit.h>

@interface OtherPeopleViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *table1B;
@property (weak, nonatomic) IBOutlet UIButton *table2B;





@property (strong, nonatomic) IBOutlet UITableViewCell *iconCell;

@property (strong, nonatomic) IBOutlet UIView *btnView;
@property (strong, nonatomic) IBOutlet UITableView *table1;
@property (strong, nonatomic) IBOutlet UITableView *table2;


@end
