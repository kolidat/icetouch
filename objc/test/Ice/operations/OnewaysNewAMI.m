// **********************************************************************
//
// Copyright (c) 2003-2014 ZeroC, Inc. All rights reserved.
//
// This copy of Ice Touch is licensed to you under the terms described in the
// ICE_TOUCH_LICENSE file included in this distribution.
//
// **********************************************************************

#import <Ice/Ice.h>
#import <TestCommon.h>
#import <OperationsTest.h>

#import <Foundation/Foundation.h>

@interface OnewayNewAMICallback : NSObject
{
    BOOL called;
    NSCondition* cond;
}
-(void) check;
-(void) called;
@end

@implementation OnewayNewAMICallback
-(id) init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    cond = [[NSCondition alloc] init];
    return self;
}

+(id) create
{
#if defined(__clang__) && __has_feature(objc_arc)
    return [[OnewayNewAMICallback alloc] init];
#else
    return [[[OnewayNewAMICallback alloc] init] autorelease];
#endif
}

#if defined(__clang__) && !__has_feature(objc_arc)
-(void) dealloc
{
    [cond release];
    [super dealloc];
}
#endif

-(void) check
{
    [cond lock];
    while(!called)
    {
        [cond wait];
    }
    called = NO;
    [cond unlock];
}
-(void) called
{
    [cond lock];
    called = YES;
    [cond signal];
    [cond unlock];
}
-(void) opVoidResponse
{
    [self called];
}
-(void) opVoidException:(ICEException*)ex
{
    test(NO);
}
-(void) opVoidExResponse
{
    test(NO);
}
-(void) opVoidExException:(ICEException*)ex
{
    test([ex isKindOfClass:[ICENoEndpointException class]]);
    [self called];
}
-(void) opByteExResponse
{
    test(NO);
}
-(void) opByteEx:(ICEException*)ex
{
    test(NO);
}
-(void) opByteExException:(ICEException*)ex
{
    test([ex isKindOfClass:[ICETwowayOnlyException class]]);
    [self called];
}
@end

void
onewaysNewAMI(id<ICECommunicator> communicator, id<TestOperationsMyClassPrx> proxy)
{
    id<TestOperationsMyClassPrx> p = [TestOperationsMyClassPrx uncheckedCast:[proxy ice_oneway]];

    {
        OnewayNewAMICallback* cb = [OnewayNewAMICallback create];
        [p begin_opVoid:^() { [cb opVoidResponse]; } exception:^(ICEException* ex) { [cb opVoidException:ex]; }];
    }

    {
        OnewayNewAMICallback* cb = [OnewayNewAMICallback create];
        @try
        {
            [p begin_opByte:0 p2:0 response:^(ICEByte r, ICEByte p3) { [cb opByteExResponse]; } exception:^(ICEException* ex) { [cb opByteExException:ex]; }];
            [cb check];
        }
        @catch(NSException* ex)
        {
            test([ex name] == NSInvalidArgumentException);
        }
    }
}
