//
//  otherFileVC.m
//  openFile
//
//  Created by 凯悦 on 2019/6/21.
//  Copyright © 2019 kaiyue. All rights reserved.
//

#import "otherFileVC.h"

@interface otherFileVC ()<UIDocumentInteractionControllerDelegate>
{
    UIDocumentInteractionController *documentInteractionController;
}
@property (weak, nonatomic) IBOutlet UILabel *fileNameLab;
@property (weak, nonatomic) IBOutlet UIButton *openOtherBtn;

@end

@implementation otherFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fileNameLab.text = [NSString stringWithFormat:@"%@.%@",self.fileName,self.fileType];}
- (IBAction)openFileAction:(id)sender {

    NSString * filePath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:self.fileType];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
    [documentInteractionController setDelegate:self];
    CGRect rect = CGRectMake(self.view.bounds.size.width, 40.0, 0.0, 0.0);
    [documentInteractionController presentOpenInMenuFromRect:rect inView:self.view animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
