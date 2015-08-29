//
//  OtherPeopleViewController.m
//
//
//  Created by 罗德昭 on 15/7/24.
//
//

#import "OtherPeopleViewController.h"
#import "MJRefresh.h"
@interface OtherPeopleViewController () <UIScrollViewDelegate>
{
    UIScrollView *mainScrollView;
    CGFloat a;
    BOOL shoulere;
    BOOL isTable1;
}

@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) NSMutableArray *data1;
@property (nonatomic,strong) NSMutableArray *data2;
@property (nonatomic,strong) NSMutableArray *myHeight;
@property (nonatomic,assign) BOOL shouldre;
@property (nonatomic,assign) BOOL istable1;

@end

@implementation OtherPeopleViewController

- (NSArray *)data2 {
    if (!_data2) {
        _data2 = [NSMutableArray array];
        for (int i = 0;i < 23;i++) {
            NSString * ns = [NSString stringWithFormat:@"%d",i];
            [_data2 addObject: ns ];
        }
    }
    return _data2;
}
- (NSArray *)data1 {
    if (!_data1) {
        _data1 = [NSMutableArray array];
        for (int i = 0;i < 23;i++) {
            NSString *ns = [NSString stringWithFormat:@"%d",i];
            [_data1 addObject:ns ];
        }
        
    }
    return _data1;
}
- (BOOL)shouldre {
    if (_shouldre) {
        _shouldre = YES;
    }
    return _shouldre;
}
-(BOOL)istable1
{
    if (!_istable1) {
        _istable1 = YES;
    }
    return _istable1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    self.tableView.footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.tableView.backgroundColor = [UIColor   whiteColor];
    
    [self.table2 setScrollEnabled:NO];
    [self.table1 setScrollEnabled:NO];
    [self showTable1];
    
    
}
- (void)headerRefreshing
{
    NSLog(@" 下拉刷新");
    [self.tableView.header endRefreshing];
    
}
- (void)loadmore
{
    NSLog(@" 上拉加载");
    [self.tableView.footer endRefreshing];
}
- (void)getmainSCroll
{
    mainScrollView = [[UIScrollView alloc]init];
    mainScrollView.pagingEnabled=YES;
    float scrollHeight = [UIScreen mainScreen].bounds.size.height-144-64-55;
    
    if (scrollHeight < self.table1.contentSize.height) {
        scrollHeight = self.table1.contentSize.height;
    }
    [mainScrollView setBackgroundColor:[UIColor whiteColor]];
    mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, scrollHeight);
    [mainScrollView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, scrollHeight)];
    [self.table2 setScrollEnabled:NO];
    
    self.table1.frame = CGRectMake(0, 0, CGRectGetWidth(mainScrollView.bounds),self.table1.contentSize.height);
    
    self.table2.frame = CGRectMake(CGRectGetWidth(mainScrollView.bounds), 0, CGRectGetWidth(mainScrollView.bounds), self.table2.contentSize.height);
    
    
    mainScrollView.contentInset = UIEdgeInsetsZero;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.bounces = NO;
    mainScrollView.tag = 100;
    mainScrollView.delegate = self;
    [mainScrollView addSubview:self.table2];
    [mainScrollView addSubview:self.table1];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView.tag == 0)
    {
        return 2;
    }
    else
        return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag == 0)
    {
        return 1;
    }
    else if (tableView.tag == 1)
    {
        
        return self.data1.count;
    }
    else
    {
        return self.data2.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableView])
    {
        UITableViewCell * cell=nil;
        static NSString * ID = @"cell";
        if(indexPath.section == 0)
        {
            return self.iconCell;
        }
        else
        {
            cell=[tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            if (!self.shouldre) {
                
                
                [self getmainSCroll];
                
            }
            NSLog(@"%d",self.shouldre);
            [cell.contentView addSubview:mainScrollView];
            return cell;
            
        }
    }
    else if (tableView.tag == 1) {
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(!cell1)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            
        }
        cell1.textLabel.text = self.data1[indexPath.row];
        
        return cell1;
    }
    else
    {
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if(!cell2)
        {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        cell2.textLabel.text = self.data2[indexPath.row];
        return cell2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == 0)
    {
        if(indexPath.section==0)
        {
            return 144;
        }
        else
        {
            float bb = [UIScreen mainScreen].bounds.size.height-144-64-55;
            
            if (!isTable1)
            {
                if(self.table2.contentSize.height > bb)
                {
                    
                    return  self.table2.contentSize.height;
                }
                else
                {
                    return bb;
                }
            }
            
            if (isTable1)
            {
                if (self.table1.contentSize.height > bb)
                {
                    
                    return self.table1.contentSize.height;
                    
                    
                }
                else
                {
                    
                    return    bb;
                }
            }
        }
    }
    else if(tableView.tag == 1)
    {
        [self.tableView reloadData];
        return 140;
    }
    else{
        [self.tableView reloadData];
        return 40;
        
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        
        
        if (section == 0) {
            return 0.1;
        }else
        {
            return 55;
        }
    }
    else
    {
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        
        
        if (section == 1) {
            return self.btnView;
        }else
            return nil;
    }else
    {
        return nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView.tag == 100)
    {
        float x = scrollView.contentOffset.x;
        CGFloat width = mainScrollView.bounds.size.width;
        if (x >width/2 && x <= width) {
            
            self.shouldre = YES;
            [self showTable2];
            
        }
        
        if (x >= 0 && x < width/2) {
            self.shouldre = YES;
            
            [self showTable1];
            
        }
    }
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 100)
    {
        float x = scrollView.contentOffset.x;
        CGFloat width = mainScrollView.bounds.size.width;
        if (x >width/2 && x <= width) {
            self.shouldre = YES;
            if( [UIScreen mainScreen].bounds.size.height - 144 - 64 - 55 > self.table2.contentSize.height)
            {
                [mainScrollView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 144 - 64 - 55)];
                mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2,[UIScreen mainScreen].bounds.size.height - 144 - 64 - 55 ) ;
            }
            else
            {
                [mainScrollView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.table2.contentSize.height)];
                mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2,self.table2.contentSize.height) ;
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [self showTable2];
            
        }
        if (x >= 0 && x < width / 2) {
            self.shouldre = YES;
            if( [UIScreen mainScreen].bounds.size.height - 144 - 64 - 55 > self.table1.contentSize.height)
            {
                [mainScrollView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 144 - 64 - 55)];
                mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2,[UIScreen mainScreen].bounds.size.height - 144 - 64 - 55 ) ;
            }
            else
            {
                [mainScrollView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.table1.contentSize.height)];
                mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2,self.table1.contentSize.height) ;
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            [ self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            
            [self showTable1];
            
        }
    }
    
}
-(void)showTable1
{
    isTable1 = YES;
    [self.table1B setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.table2B setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
}
-(void)showTable2
{
    
    isTable1 = NO;
    [self.table1B setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.table2B setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
}




@end
