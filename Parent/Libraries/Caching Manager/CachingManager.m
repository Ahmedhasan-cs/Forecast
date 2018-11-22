//
//  CachingManager.m
//  Elmagmo3
//
//  Created by AHMED ALY on 3/1/14.
//  Copyright (c) 2014 AHMED ALY. All rights reserved.
//

#import "CachingManager.h"

@implementation CachingManager

+ (id)sharedCachingManager {
    
    static CachingManager *sharedMyCachingManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyCachingManager = [[self alloc] init];
    });
    return sharedMyCachingManager;
}

+ (void)saveArrayToPlist:(NSArray *)data withName:(NSString *)saveName inRelativePath:(NSString *)path inDocument:(BOOL)inDocument{
    NSArray *documentPaths =nil;
    
    if (inDocument) {
        documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    }else
        documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	
	NSString *folder = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:path];
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:NULL];
	[data writeToFile:[folder stringByAppendingPathComponent:saveName] atomically:YES];
}

+ (NSArray *)getArrayWithName:(NSString *)dataName inRelativePath:(NSString *)path inDocument:(BOOL)inDocument{
    NSArray *documentPaths =nil;
    if (inDocument) {
        documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    }else
        documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
	NSString *folder = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:path];
	NSString *dataPath = [folder stringByAppendingPathComponent:dataName];

	
	return [NSArray arrayWithContentsOfFile:dataPath];
}
+ (void)addObject:(id)objectValue withKey:(NSString *)objectKey ifKeyNotExists:(BOOL)keyCheck{
    
    // NSLog(@"dict=%@",objectValue);
	if ((objectKey != nil) && !keyCheck) {
		[[NSUserDefaults standardUserDefaults] setObject:objectValue forKey:objectKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
	} else if (objectKey != nil) {
		NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:objectKey];
		if (returnObject == nil) {
			[[NSUserDefaults standardUserDefaults] setObject:objectValue forKey:objectKey];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
}
+ (NSString *)getStringWithKey:(NSString *)key{
	NSString *userData = nil;
	
	if (key != nil) {
		NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (!returnObject) {
            return nil;
        }
		if ([returnObject isKindOfClass:[NSArray class]]) {
			userData = (NSString *)returnObject;
		}
        
        else
            userData = [NSString stringWithFormat:@"%@",returnObject];
	}
	
	return userData;
}

+ (NSArray *)getArrayWithKey:(NSString *)key{
	NSArray *userData = nil;
	
	if (key != nil) {
		NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (!returnObject) {
            return nil;
        }
		if ([returnObject isKindOfClass:[NSArray class]]) {
			userData = (NSArray *)returnObject;
		}

	}
	
	return userData;
}

+ (NSDate *)getDateWithKey:(NSString *)key{
	NSDate *date = nil;
	
	if (key != nil) {
		NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (!returnObject) {
            return nil;
        }
		if ([returnObject isKindOfClass:[NSDate class]]) {
			date = (NSDate *)returnObject;
		}
        
	}
	
	return date;
}
+ (NSDictionary *)getDictionaryWithKey:(NSString *)key{
    NSDictionary *data = nil;
    
    if (key != nil) {
        NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (!returnObject) {
            return nil;
        }
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            data = (NSDictionary *)returnObject;
        }
        
    }
    
    return data;
}

+ (NSData *)getDataWithName:(NSString *)dataName inRelativePath:(NSString *)path{
    NSArray *documentPaths =nil;
    documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *folder = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:path];
    NSString *dataPath = [folder stringByAppendingPathComponent:dataName];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    return [fm contentsAtPath:dataPath];
}

+ (void)saveData:(NSData *)data withName:(NSString *)saveName inRelativePath:(NSString *)path{
    NSArray *documentPaths =nil;
    documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
   
    NSString *folder = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:path];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:NULL];
    [data writeToFile:[folder stringByAppendingPathComponent:saveName] atomically:YES];
}
@end
