// **********************************************************************
//
// Copyright (c) 2003-2014 ZeroC, Inc. All rights reserved.
//
// This copy of Ice Touch is licensed to you under the terms described in the
// ICE_TOUCH_LICENSE file included in this distribution.
//
// **********************************************************************

#import <Ice/Config.h>

#import <Ice/Current.h>

//
// Forward declarations.
//
@class ICEObject;
@protocol ICEInputStream;
@protocol ICEOutputStream;

#if defined(__cplusplus)
extern "C"
#endif
int ICEInternalLookupString(NSString * const
 arr[], size_t, NSString * __unsafe_unretained);
#if defined(__cplusplus)
extern "C"
#endif
void ICEInternalCheckModeAndSelector(id, ICEOperationMode, SEL, ICECurrent*);

@interface ICEInternalPrefixTable : NSObject
@end

@protocol ICERequest <NSObject>
-(ICECurrent*) getCurrent;
@end

@protocol ICEObject <NSObject>
-(BOOL) ice_isA:(NSString*)typeId current:(ICECurrent*)current;
-(void) ice_ping:(ICECurrent*)current;
-(NSString*) ice_id:(ICECurrent*)current;
-(NSArray*) ice_ids:(ICECurrent*)current;
@end

@interface ICEObject : NSObject<ICEObject, NSCopying>
{
    void* object__;
    id delegate__;
}
-(id)initWithDelegate:(id)delegate;
+(id)objectWithDelegate:(id)delegate;
-(BOOL) ice_isA:(NSString*)typeId;
-(void) ice_ping;
-(NSString*) ice_id;
-(NSArray*) ice_ids;
-(void) ice_preMarshal;
-(void) ice_postUnmarshal;
-(BOOL) ice_dispatch:(id<ICERequest>)request;
+(NSString*) ice_staticId;
+(NSString*const*) staticIds__:(int*)count idIndex:(int*)idx;
+(BOOL) ice_isA___:(id)servant current:(ICECurrent*)current is:(id<ICEInputStream>)is os:(id<ICEOutputStream>)os;
+(BOOL) ice_ping___:(id)servant current:(ICECurrent*)current is:(id<ICEInputStream>)is os:(id<ICEOutputStream>)os;
+(BOOL) ice_id___:(id)servant current:(ICECurrent*)current is:(id<ICEInputStream>)is os:(id<ICEOutputStream>)os;
+(BOOL) ice_ids___:(id)servant current:(ICECurrent*)current is:(id<ICEInputStream>)is os:(id<ICEOutputStream>)os;
-(BOOL) dispatch__:(ICECurrent*)current is:(id<ICEInputStream>)is os:(id<ICEOutputStream>)os;
-(void) write__:(id<ICEOutputStream>)os;
-(void) writeImpl__:(id<ICEOutputStream>)os;
-(void) read__:(id<ICEInputStream>)is;
-(void) readImpl__:(id<ICEInputStream>)is;
-(id)target__;
@end

@protocol ICEBlobject<ICEObject>
-(BOOL) ice_invoke:(NSData*)inEncaps outEncaps:(NSMutableData**)outEncaps current:(ICECurrent*)current;
@end

@interface ICEBlobject : ICEObject
@end
