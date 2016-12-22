//
//  ViewController.m
//  FLFileManager
//
//  Created by __阿彤木_ on 12/22/16.
//  Copyright © 2016 fanxn. All rights reserved.
//

#import "ViewController.h"
#import "FLFileManager.h"
@interface ViewController ()
{
    FLFileManager *_manager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _manager = [FLFileManager shareInstance];
    NSString *filename = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tmp"] stringByAppendingPathComponent:@"success"] stringByAppendingPathComponent:@"hehehda"];;
    NSFileManager *fileman = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if (![fileman fileExistsAtPath:filename isDirectory:&isDir])
    {
        // Create the directory
        NSError  *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:filename withIntermediateDirectories:NO attributes:nil error:&error];
    }
    else if (!isDir)
    {
        NSLog(@"Cannot proceed!");
        // Throw exception
    }
}

- (void)initFileSystem {
    if ([_manager createDirectoryAtSandbox:FLSandBoxPathDocuments subpath:@"CustomServiceSDK/abc"]) {
        NSLog(@"create directory success");
    } else {
        NSLog(@"create directory failed");
    }
    
    if ([_manager createFileAtSandbox:FLSandBoxPathDocuments fullSubpath:@"CustomServiceSDK/abc/easemob.db"]) {
        NSLog(@"create file success");
    } else {
        NSLog(@"create file failed ");
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self initFileSystem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
