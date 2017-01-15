//
//  MyPcTableView.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/27.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "MyPcTableView.h"

@implementation MyPcTableView

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _activity = [[UIActivityIndicatorView alloc]
                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.frame = CGRectMake(kWindowWidth-kWindowWidth/6, 0, kWindowWidth / 6, kWindowWidth / 6);
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _diskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *DiskTableID = @"MytableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DiskTableID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DiskTableID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    cell.textLabel.text = [_diskArray[indexPath.row] objectForKey:@"Name"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    cell.imageView.image = [UIImage imageNamed:@"folder"];
    // NSLog(@"%@",cell.textLabel.text);
    //cell.textLabel.text = @"111";
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *myDesk = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myDesk.frame = CGRectMake(0, 0, kWindowWidth, kWindowHeight/8);
    [myDesk setTitle:@"我的桌面" forState:UIControlStateNormal];
    myDesk.titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    myDesk.tintColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:1.0];
    [myDesk addTarget:self action:@selector(getMyDesk) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:myDesk];
    return view;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWindowHeight/8;
    
}
//-(NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWindowHeight/8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell addSubview:_activity];
    [_activity startAnimating];
    NSString *fullName = [_diskArray[indexPath.row] objectForKey:@"Name"];
//    NSString *name = [_diskArray[indexPath.row] objectForKey:@"FullName"];
//    NSString *label = [_diskArray[indexPath.row] objectForKey:@"FullName"];
//    NSDictionary *diskCmdDic = [NSDictionary dictionaryWithObjectsAndKeys: fullName, @"FullName", name,  @"Name",label, @"Label",  nil];
    
    NSDictionary *diskCmdDic = [NSDictionary dictionaryWithObjectsAndKeys: fullName, @"FullName", [NSNull null],  @"Name",@"PPTSHOW", @"Label", [NSNull null],@"FileTyp",  nil];
    
    [self.myPcTvcDeleate myPcTableViewCmd:diskCmdDic];
    [_activity stopAnimating];
}
- (void)getMyDesk {
    [self.tableHeaderView addSubview:_activity];
    [_activity startAnimating];
    
    NSDictionary *diskCmdDic = [NSDictionary dictionaryWithObjectsAndKeys: @"Desktop", @"FullName", [NSNull null],  @"Name",@"PPTSHOW", @"Label", [NSNull null],@"FileTyp",  nil];
    [self.myPcTvcDeleate myPcTableViewCmd:diskCmdDic];
    [_activity stopAnimating];
    

}

@end
