//
//  FLFileManager.h
//  FLFileManager
//
//  Created by afanda on 12/22/16.
//  Copyright © 2016 fanxn. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FLSandboxPath) {
    FLSandBoxPathDocuments = 1,
    FLSandBoxPathLibrary,
    FLSandBoxPathCaches,
    FLSandBoxPathTmp,
};
@interface FLFileManager : NSObject
@property(nonatomic,copy,readonly) NSString *documents;
@property(nonatomic,copy,readonly) NSString *library;
@property(nonatomic,copy,readonly) NSString *caches;
@property(nonatomic,copy,readonly) NSString *tmp;

+ (instancetype)shareInstance;

- (BOOL)fileExitsAtSandbox:(FLSandboxPath)sandbox subpath:(NSString *)subpath;

- (BOOL)createDirectoryAtSandbox:(FLSandboxPath)sandbox subpath:(NSString *)subpath;

- (BOOL)createFileAtSandbox:(FLSandboxPath)sandbox fullSubpath:(NSString *)fullSubpath;

- (BOOL)removeItemAtSandbox:(FLSandboxPath)sandbox subpath:(NSString *)subpath;
@end
