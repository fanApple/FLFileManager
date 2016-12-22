//
//  FLFileManager.m
//  FLFileManager
//
//  Created by afanda on 12/22/16.
//  Copyright © 2016 fanxn. All rights reserved.
//

#import "FLFileManager.h"

@implementation FLFileManager
{
    NSFileManager *_manager;
}
- (NSString *)documents {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [paths firstObject];
}

- (NSString *)library {
    return 	[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
}

- (NSString *)caches {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    return [paths firstObject];
}

static FLFileManager *instance = nil;
+ (instancetype)shareInstance {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    _manager = [NSFileManager defaultManager];
    return [super init];
}
//determine if a file exits
- (BOOL)fileExitsAtSandbox:(FLSandboxPath)sandbox subpath:(NSString *)subpath {
    BOOL isDirectory = NO;
    NSString *filePath = [[self getSandboxPathWithFLSandbox:sandbox] stringByAppendingPathComponent:subpath];
    BOOL fileExists = [_manager fileExistsAtPath:filePath isDirectory:&isDirectory];
    return fileExists;
}

//create directory
- (BOOL)createDirectoryAtSandbox:(FLSandboxPath)sandbox subpath:(NSString *)subpath {
    NSArray *folders = [subpath componentsSeparatedByString:@"/"];
    NSString *directory = [self getSandboxPathWithFLSandbox:sandbox];
    for (int i=0; i<folders.count; i++) {
        directory = [directory stringByAppendingPathComponent:folders[i]];
        BOOL isSuccess;
        if (![_manager fileExistsAtPath:directory]) {
            NSError *error = [[NSError alloc] init];
            isSuccess = [_manager createDirectoryAtPath:directory withIntermediateDirectories:NO attributes:nil error:&error];
        }
        if (!isSuccess) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)createFileAtSandbox:(FLSandboxPath)sandbox fullSubpath:(NSString *)fullSubpath {
    NSString *fullPath = [[self getSandboxPathWithFLSandbox:sandbox] stringByAppendingPathComponent:fullSubpath];
    if ([_manager fileExistsAtPath:fullSubpath]) {
        return YES;
    }
    BOOL isSucces = [_manager createFileAtPath:fullPath contents:nil attributes:nil];

    return isSucces;
}

- (BOOL)removeItemAtSandbox:(FLSandboxPath)sandbox subpath:(NSString *)subpath {
    NSString *fullPath = [[self getSandboxPathWithFLSandbox:sandbox] stringByAppendingPathComponent:subpath];
    BOOL isSuccess=[_manager removeItemAtPath:fullPath error:nil];
    return isSuccess;
}

//private
- (NSString *)getSandboxPathWithFLSandbox:(FLSandboxPath)sandbox {
    switch (sandbox) {
        case FLSandBoxPathDocuments: {
            return self.documents;
            break;
        }
            case FLSandBoxPathLibrary: {
                return self.library;
            break;
        }
        case FLSandBoxPathCaches: {
            return self.caches;
            break;
        }
        case FLSandBoxPathTmp: {
            return self.tmp;
            break;
        }
        default: {
            return nil;
            break;
        }
    }
    return nil;
}

@end
