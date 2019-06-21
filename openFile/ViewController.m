//
//  ViewController.m
//  openFile
//
//  Created by 凯悦 on 2019/6/21.
//  Copyright © 2019 kaiyue. All rights reserved.
//

#import "ViewController.h"
#import "otherFileVC.h"
#define SSCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)   //屏幕宽度
#define SSCREEN_HEIGHT      ([UIScreen mainScreen].bounds.size.height)  //屏幕高度
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate>
{
    NSArray *dataArr;
}
@property(nonatomic,strong)UITableView           *tableView;
@end

@implementation ViewController
-(UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SSCREEN_WIDTH, SSCREEN_HEIGHT)];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    dataArr = @[
                @{@"fileName":@"test",@"fileType":@"pdf"},
                @{@"fileName":@"需求清单",@"fileType":@"xlsx"},
                @{@"fileName":@"各部门流程",@"fileType":@"docx"},
                @{@"fileName":@"枪cad文件",@"fileType":@"dwg"},
                ];
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *kcell = @"KCell_2_2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@.%@",[dataArr[indexPath.row]objectForKey:@"fileName"],[dataArr[indexPath.row]objectForKey:@"fileType"]];
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fileType = [dataArr[indexPath.row]objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"docx"]||[fileType isEqualToString:@"doc"]||[fileType isEqualToString:@"xlsx"]||[fileType isEqualToString:@"pdf"]) {
        //打开office文件
         NSString * filePath = [[NSBundle mainBundle] pathForResource:[dataArr[indexPath.row]objectForKey:@"fileName"] ofType:[dataArr[indexPath.row]objectForKey:@"fileType"]];
        [self openDocxWithPath:filePath];
    }else
    {
        //未知文件类型,用其他应用打开
        otherFileVC *otherFile = [[otherFileVC alloc]init];
        otherFile.fileName = [dataArr[indexPath.row]objectForKey:@"fileName"];
        otherFile.fileType = [dataArr[indexPath.row]objectForKey:@"fileType"];
        [self.navigationController pushViewController:otherFile  animated:YES];
    }
}
/**
 打开文件
 @param filePath 文件路径
 */
-(void)openDocxWithPath:(NSString *)filePath {
    
    UIDocumentInteractionController *doc= [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    doc.delegate = self;
    [doc presentPreviewAnimated:YES];
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"1");
    return self;
}

-(UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller {
    NSLog(@"2");
    return self.view;
}


@end
