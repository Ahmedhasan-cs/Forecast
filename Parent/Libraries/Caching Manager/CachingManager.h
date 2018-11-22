//
//  CachingManager.h
//
//
//  Created by AHMED ALY on 3/1/14.
//  Copyright (c) 2014 AHMED ALY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CachingManager : NSObject
+ (id)sharedCachingManager ;
+ (void)saveArrayToPlist:(NSArray *)data withName:(NSString *)saveName inRelativePath:(NSString *)path inDocument:(BOOL)inDocument;
+ (NSArray *)getArrayWithName:(NSString *)dataName inRelativePath:(NSString *)path inDocument:(BOOL)inDocument;
+ (void)addObject:(id)objectValue withKey:(NSString *)objectKey ifKeyNotExists:(BOOL)keyCheck;
+ (NSString *)getStringWithKey:(NSString *)key;
+ (NSArray *)getArrayWithKey:(NSString *)key;
+ (NSDictionary *)getDictionaryWithKey:(NSString *)key;
+ (NSDate *)getDateWithKey:(NSString *)key;
+ (NSData *)getDataWithName:(NSString *)dataName inRelativePath:(NSString *)path;
+ (void)saveData:(NSData *)data withName:(NSString *)saveName inRelativePath:(NSString *)path;
@end
