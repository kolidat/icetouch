// **********************************************************************
//
// Copyright (c) 2003-2014 ZeroC, Inc. All rights reserved.
//
// This copy of Ice Touch is licensed to you under the terms described in the
// ICE_TOUCH_LICENSE file included in this distribution.
//
// **********************************************************************

#import <Foundation/Foundation.h>

@class ICEException;

enum LogEntryType
{
    LogEntryTypeTrace,
    LogEntryTypeWarning,
    LogEntryTypeError,
    LogEntryTypePrint,
};
typedef enum LogEntryType LogEntryType;

@interface LogEntry : NSObject
{
    LogEntryType type;
    NSDate* timestamp;
    NSString* category;
    NSString* message;
}

@property (nonatomic, readonly) LogEntryType type;
@property (nonatomic, readonly) NSDate* timestamp;
@property (nonatomic, readonly) NSString* category;
@property (nonatomic, readonly) NSString* message;

+(id)logEntryPrint:(NSString*)message NS_RETURNS_RETAINED;
+(id)logEntryTrace:(NSString*)message category:(NSString*)category NS_RETURNS_RETAINED;
+(id)logEntryWarning:(NSString*)message NS_RETURNS_RETAINED;
+(id)logEntryError:(NSString*)message NS_RETURNS_RETAINED;

@end

@protocol LoggingDelegate<NSObject>

-(void)log:(LogEntry*)s;

@end
