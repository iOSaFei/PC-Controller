//
//  MyPcTableViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/27.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "MyPcTableViewController.h"

@interface MyPcTableViewController ()

@end

@implementation MyPcTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
}
- (void)addBackButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    backButton.frame = CGRectMake(0, 0, 30, 30);
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)back {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _diskTvArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DiskTableID = @"MytableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DiskTableID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DiskTableID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    if([[_diskTvArray[indexPath.row] objectForKey:@"FileTyp"] isEqualToString:@"Directory"]){
        cell.imageView.image = [UIImage imageNamed:@"folder"];
    }else {
        cell.imageView.image = [UIImage imageNamed:@"file"];
    }
    cell.textLabel.text = [_diskTvArray[indexPath.row] objectForKey:@"Name"];
    

   // NSLog(@"%@",cell.textLabel.text);
    //cell.textLabel.text = @"111";
    return cell;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWindowHeight/8;
    
}
-(NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[_diskTvArray[indexPath.row] objectForKey:@"FileTyp"] isEqualToString:@"Directory"]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _activity = [[UIActivityIndicatorView alloc]
                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.frame = CGRectMake(kWindowWidth-kWindowWidth/6, 0, kWindowWidth / 6, kWindowWidth / 6);
        [_activity startAnimating];
        [cell addSubview:_activity];
        NSString *name = [_diskTvArray[indexPath.row] objectForKey:@"Name"];
        NSLog(@"%@",name);
        NSString *fullName = [_diskTvArray[indexPath.row] objectForKey:@"FullName"];
        NSLog(@"%@",fullName);
        NSString *label = [_diskTvArray[indexPath.row] objectForKey:@"Lable"];
        NSDictionary *diskCmdDic = [NSDictionary dictionaryWithObjectsAndKeys: fullName, @"FullName", label, @"Lable", name, @"Name",  nil];
        NSString *s = [CodeJSON codeJson:diskCmdDic];
        NSString *diskCmdJson = [NSString stringWithFormat:@"XiYouInfo#%@",s];
        CmdAsyncSocketModel *cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
        [cmdAsyncSocketModel sendCmd:diskCmdJson];
        cmdAsyncSocketModel.cmdDelegate = self;
    }else {
        UIAlertController *isDownload = [UIAlertController alertControllerWithTitle:@"下载文件" message:@"您将要下载此文件" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *name = [_diskTvArray[indexPath.row] objectForKey:@"Name"];
            NSLog(@"%@",name);
            NSString *fullName = [_diskTvArray[indexPath.row] objectForKey:@"FullName"];
            NSLog(@"%@",fullName);
            NSDictionary *fileCmdDic = [NSDictionary dictionaryWithObjectsAndKeys: @"FileDownload", @"Typ", [NSNumber numberWithInt:0], @"Size", name, @"Name",fullName,@"Msg", nil];
            NSLog(@"%@",fileCmdDic);
            NSString *s = [CodeJSON codeJson:fileCmdDic];
            NSLog(@"%@",s);
            // NSString *diskCmdJson = [NSString stringWithFormat:@"XiYouInfo#%@",s];
            FileAsyncSocketModel *fileAsyncSocketModel = [FileAsyncSocketModel fileSharedInstance];
            [fileAsyncSocketModel sendFileCmd:s withFileName:name];
           // fileAsyncSocketModel.fileDelegate = self;
        }];
        [isDownload addAction:no];
        [isDownload addAction:yes];
        [self presentViewController:isDownload animated:YES completion:nil];
    }
}
- (void)diskDidReadData:(NSArray *)array {
    MyPcTableViewController *myPcTableViewController = [[MyPcTableViewController alloc] init];
    myPcTableViewController.diskTvArray = array;
    NSLog(@"%@",myPcTableViewController.diskTvArray);
    [_activity stopAnimating];
    UINavigationController *nPcVc = [[UINavigationController alloc] initWithRootViewController:myPcTableViewController];
    [self.navigationController presentViewController:nPcVc animated:YES completion:nil];
}
//- (void)fileConectSuccess {
//    
//}
//- (void)fileConectFail {
//    
//}
//- (void)fileDidReadData:(NSArray *)array {
//    NSLog(@"%@",array);
//}
- (void)cmdConectSuccess {
    
}
- (void)cmdConectFail {
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
