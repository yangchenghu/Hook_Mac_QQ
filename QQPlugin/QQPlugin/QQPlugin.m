//
//  QQPlugin.m
//  QQPlugin
//
//  Created by yangchenghu on 7/16/14.
//  Copyright (c) 2014 yangchenghu. All rights reserved.
//

#import "QQPlugin.h"

#include <stdio.h>
#include <objc/runtime.h>
#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>

@implementation QQPlugin

static IMP sOriginalEmailImp = NULL;
static IMP sOriginalQZoneImp = NULL;
static IMP sOriginalWBlogImp = NULL;

static IMP sOriginalShowDockCountImp  = NULL;

/*
 char -[UnreadMsgMgr isShowCountOnDock](void * self, void * _cmd) {
 [self initPreference];
 eax = sign_extend_32(*(int8_t *)(self + 0x10));
 return eax;
 }

 */


+ (void)load
{
    sOriginalEmailImp = [[self class] repleaseOldClass:@"MainWindowController"
                                              newClass:NSStringFromClass([self class])
                                            oldMethods:@"setNewEmailCount:"
                                            newMethods:@"ychsetNewEmailCount:"];
    
    sOriginalQZoneImp = [[self class] repleaseOldClass:@"MainWindowController"
                                              newClass:NSStringFromClass([self class])
                                            oldMethods:@"setNewQzoneCount:"
                                            newMethods:@"ychsetNewQzoneCount:"];
    
    sOriginalWBlogImp = [[self class] repleaseOldClass:@"MainWindowController"
                                              newClass:NSStringFromClass([self class])
                                            oldMethods:@"setNewWBlogCount:"
                                            newMethods:@"ychsetNewWBlogCount:"];
    
    sOriginalShowDockCountImp = [[self class] repleaseOldClass:@"UnreadMsgMgr"
                                              newClass:NSStringFromClass([self class])
                                            oldMethods:@"isShowCountOnDock"
                                            newMethods:@"ychisShowCountOnDock"];
    
    
}

+ (IMP)repleaseOldClass:(NSString *)strOldClass
               newClass:(NSString *)strNewClass
             oldMethods:(NSString *)strOldMethod
             newMethods:(NSString *)strNewMethod
{
    Class originalClass = NSClassFromString(strOldClass);
	Method originalMeth = class_getInstanceMethod(originalClass, NSSelectorFromString(strOldMethod));
    IMP impOriginal = method_getImplementation(originalMeth);
	Method replacementMeth = class_getInstanceMethod(NSClassFromString(strNewClass), NSSelectorFromString(strNewMethod));
	method_exchangeImplementations(originalMeth, replacementMeth);
    
    return impOriginal;
}

- (void)ychsetNewQzoneCount:(unsigned long)arg1
{
    // Run our custom code which simply display an alert
//	NSAlert *alert = [NSAlert alertWithMessageText:@"Code has been injected!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"get server qzone count is:%ld", arg1];
//	[alert runModal];
    NSLog(@"get server qzone count is:%ld", arg1);
}

- (void)ychsetNewWBlogCount:(unsigned long)arg1
{
//    printf("get server wblog count is:%ld", arg1);
    NSLog(@"get server wblog count is:%ld", arg1);
}

- (void)ychsetNewEmailCount:(unsigned long)arg1
{
    // Run our custom code which simply display an alert
//	NSAlert *alert = [NSAlert alertWithMessageText:@"Code has been injected!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"get server email count is:%ld", arg1];
//	[alert runModal];
    
    NSLog(@"get server email count is:%ld", arg1);
}

- (BOOL)ychisShowCountOnDock
{
    BOOL bResult = (BOOL)(IMP)sOriginalShowDockCountImp;
    NSLog(@"ychisShowCountOnDock is :%@", (bResult ? @"YES" : @"NO"));
    NSFileManager * filemanager = [NSFileManager defaultManager];
    NSString * filepath = [[filemanager currentDirectoryPath] stringByAppendingPathComponent:@"qqshowread"];;
    NSLog(@"show path :%@", filepath);
    BOOL bReturn = [filemanager fileExistsAtPath:filepath];
    NSLog(@"return is :%@", (bReturn ? @"YES" : @"NO"));
    return bReturn;
}




@end
