//
//  ThirdViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBarButtonItem];
    [self reaFileArray];
    [self initTableView];
    [self initWebView];
}
-(void)thread1:(NSThread *)thread{
    _visitAlbum = [[UIImagePickerController alloc]init];
    NSLog(@"1");
    _visitAlbum.delegate = self;
    _visitAlbum.allowsEditing = YES;
    [_thread cancel];
}
- (void)viewWillAppear:(BOOL)animated {
    if (_downFileTableView) {
        [self reaFileArray];
        [_downFileTableView reloadData];
    }
}
- (void)initBarButtonItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"addPop"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    _backButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    _backButton.frame = CGRectMake(0, 0, 50, 50);
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
}
- (void)initWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kWindowWidth, kWindowHeight - 113)];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.allowsInlineMediaPlayback = YES;
    _webView.allowsInlineMediaPlayback = YES;
//    _webView.backgroundColor = [UIColor clearColor];
//    _webView.opaque = NO;
}
- (void)reaFileArray {
    NSString *fileNamePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fileNameArray.plist"];
   _fileNameArray  = [[NSArray alloc] initWithContentsOfFile:fileNamePath];
    
}
- (void )initTableView {
    _downFileTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kWindowWidth, kWindowHeight - 70) style:UITableViewStylePlain];
    _downFileTableView.delegate = self;
    _downFileTableView.dataSource = self;
    _downFileTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downFileTableView];

}
- (void)add:(UIButton *)button {
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread1:) object:nil];
    _thread.threadPriority = 1;
    [_thread start];
    UIAlertController *choose = [UIAlertController alertControllerWithTitle:@"上传照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *localPhoto = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _visitAlbum.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentViewController:_visitAlbum animated:YES completion:nil];
    }];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        BOOL is=[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if(!is)
        {
            UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"调用摄像头出错" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [errorAlertController addAction:okAction];
            [self presentViewController:errorAlertController animated:YES completion:nil];
            return;
        }else {
            _visitAlbum.sourceType = UIImagePickerControllerSourceTypeCamera;
            _visitAlbum.allowsEditing=YES;
            [self presentViewController:_visitAlbum animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [choose addAction:localPhoto];
    [choose addAction:takePhoto];
    [choose addAction:cancle];
    [self presentViewController:choose animated:YES completion:nil];
}

 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
     UIImage *image = info[UIImagePickerControllerOriginalImage];
     //_imageData = UIImagePNGRepresentation(image);
     _imageData = UIImageJPEGRepresentation(image, 0.1);
    [self sendPhoto];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendPhoto {
    FileAsyncSocketModel *fileAsyncSocketModel = [FileAsyncSocketModel fileSharedInstance];
    fileAsyncSocketModel.fileDelegate = self;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy-MM-dd-HH-mm-ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *dateString = [NSString stringWithFormat:@"%@.jpg",strDate];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInteger:_imageData.length], @"Size", dateString, @"Name", @"FileUpload", @"Typ", [NSNull null],@"Msg", nil];
    NSString *fileCmd = [CodeJSON codeJson:dic];
    NSLog(@"%@",fileCmd);
    [fileAsyncSocketModel sendFileCmd:fileCmd withFileName:nil];
    [fileAsyncSocketModel sendFileData:_imageData];
}
- (void)fileConectFail {
}
- (void)fileConectSuccess {
}
- (void)fileWriteSucceed {
    NSLog(@"[][][]['][][]][][]");
}
- (void)fileDidReadData:(NSData*)data withFileName:(NSString *)name{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fileNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ThirdTableID = @"MytableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThirdTableID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ThirdTableID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    cell.textLabel.text = _fileNameArray[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    cell.imageView.image = [UIImage imageNamed:@"file"];
    // NSLog(@"%@",cell.textLabel.text);
    //cell.textLabel.text = @"111";
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWindowHeight/8;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _thirdActivity = [[UIActivityIndicatorView alloc]
                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _thirdActivity.frame = CGRectMake(kWindowWidth-kWindowWidth/6, 0, kWindowWidth / 6, kWindowWidth / 6);
    [_thirdActivity startAnimating];
    [cell addSubview:_thirdActivity];
    [self reaFileData:cell.textLabel.text];
}
- (void)reaFileData:(NSString *)name {
    [_thirdActivity stopAnimating];
    self.navigationItem.leftBarButtonItem.customView.hidden = NO;
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    [self.view addSubview:_webView];
    NSString *fileCompoment = [NSString stringWithFormat:@"Documents/FileDownload/%@",name];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:fileCompoment];
    NSArray *listArray = [name componentsSeparatedByString:@"."];
    if ([[listArray lastObject] isEqualToString:@"txt"]) {
        [self showTxt:filePath];
    }else{
        [self showOther:filePath];
    }
}
- (void)showTxt:(NSString *)filePath {
    _webView.scalesPageToFit = NO;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSError *error;
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:enc error:&error];
    if (!htmlString) {
        htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        
    }
    if (!htmlString) {
        htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUnicodeStringEncoding error:&error];
    }
    if (!htmlString) {
        htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    }
    [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}
- (void)showOther:(NSString *)filePath {
    _webView.scalesPageToFit = YES;
    NSURL *url = [NSURL fileURLWithPath:filePath];//创建URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:-1];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
}
-(void)webView:(UIWebView*)webView DidFailLoadWithError:(NSError*)error{
    NSLog(@"156464645%@",error);
}
-(void)webViewDidFinishLoad:(UIWebView*)webView {
    NSLog(@"finish");
}
- (void)back {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]];
    [_webView loadRequest:request];
    [_webView removeFromSuperview];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden = NO;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
/*
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 {
 UIImage *baseImage = [info objectForKey:UIImagePickerControllerOriginalImage];
 if (baseImage == nil) return;
 compositeImage = [self addOverlayToBaseImage:baseImage];
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
 NSDate* date = [NSDate date];
 NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
 [formatter setDateFormat:@"yyyyMMddHHMMSS"];
 NSString* str = [formatter stringFromDate:date];
 //给照片按拍摄时间命名
 NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",str]];
 BOOL result=[UIImagePNGRepresentation(compositeImage)writeToFile: uniquePath atomically:YES];
 if (result) {
 NSLog(@"success");
 }
 }
*/
@end

