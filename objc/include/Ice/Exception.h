// **********************************************************************
//
// Copyright (c) 2003-2014 ZeroC, Inc. All rights reserved.
//
// This copy of Ice Touch is licensed to you under the terms described in the
// ICE_TOUCH_LICENSE file included in this distribution.
//
// **********************************************************************

#import <Ice/Config.h>

#import <Foundation/NSException.h>

//
// Forward declarations
// 
@protocol ICEOutputStream;
@protocol ICEInputStream;

@class NSCoder;

@interface ICEException : NSException
-(NSString*)ice_name;
@end

@interface ICELocalException : ICEException
{
@protected
    const char* file;
    int line;
}

@property(nonatomic, readonly) NSString* file;
@property(nonatomic, readonly) int line;

-(id)init:(const char*)file line:(int)line;
+(id)localException:(const char*)file line:(int)line;
@end

@interface ICEUserException : ICEException
-(BOOL)usesClasses__;
-(void)write__:(id<ICEOutputStream>)stream;
-(void) writeImpl__:(id<ICEOutputStream>)os;
-(void)read__:(id<ICEInputStream>)stream;
-(void) readImpl__:(id<ICEInputStream>)is;  
@end
