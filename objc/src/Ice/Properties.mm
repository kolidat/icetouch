// **********************************************************************
//
// Copyright (c) 2003-2014 ZeroC, Inc. All rights reserved.
//
// This copy of Ice Touch is licensed to you under the terms described in the
// ICE_TOUCH_LICENSE file included in this distribution.
//
// **********************************************************************

#import <Ice/PropertiesI.h>
#import <Ice/Util.h>

@implementation ICEProperties
-(id) initWithCxxObject:(IceUtil::Shared*)cxxObject
{
    self = [super initWithCxxObject:cxxObject];
    if(!self)
    {
        return nil;
    }
    properties_ = dynamic_cast<Ice::Properties*>(cxxObject);
    return self;
}
-(Ice::Properties*) properties
{
    return (Ice::Properties*)properties_;
}

// @protocol ICEProperties methods.

-(NSString*) getProperty:(NSString*)key
{
    NSException* nsex = nil;
    try
    {
        return [toNSString(properties_->getProperty(fromNSString(key))) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(NSString*) getPropertyWithDefault:(NSString*)key value:(NSString*)value
{
    NSException* nsex = nil;
    try
    {
        return [toNSString(properties_->getPropertyWithDefault(fromNSString(key), fromNSString(value))) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(int) getPropertyAsInt:(NSString*)key
{
    NSException* nsex = nil;
    try
    {
        return properties_->getPropertyAsInt(fromNSString(key));
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return 0; // Keep the compiler happy.
}
-(int) getPropertyAsIntWithDefault:(NSString*)key value:(int)value
{
    NSException* nsex = nil;
    try
    {
        return properties_->getPropertyAsIntWithDefault(fromNSString(key), value);
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return 0; // Keep the compiler happy.
}
-(NSArray*) getPropertyAsList:(NSString*)key
{
    NSException* nsex = nil;
    try
    {
        return [toNSArray(properties_->getPropertyAsList(fromNSString(key))) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(NSArray*) getPropertyAsListWithDefault:(NSString*)key value:(NSArray*)value
{
    NSException* nsex = nil;
    try
    {
        std::vector<std::string> s;
        fromNSArray(value, s);
        return [toNSArray(properties_->getPropertyAsListWithDefault(fromNSString(key), s)) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(NSDictionary*) getPropertiesForPrefix:(NSString*)prefix
{
    NSException* nsex = nil;
    try
    {
        return [toNSDictionary(properties_->getPropertiesForPrefix(fromNSString(prefix))) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(void) setProperty:(NSString*)key value:(NSString*)value
{
    NSException* nsex = nil;
    try
    {
        properties_->setProperty(fromNSString(key), fromNSString(value));
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    if(nsex != nil)
    {
        @throw nsex;
    }
}
-(NSArray*) getCommandLineOptions
{
    NSException* nsex = nil;
    try
    {
        return [toNSArray(properties_->getCommandLineOptions()) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(NSArray*) parseCommandLineOptions:(NSString*)prefix options:(NSArray*)options
{
    NSException* nsex = nil;
    try
    {
        std::vector<std::string> o;
        fromNSArray(options, o);
        return [toNSArray(properties_->parseCommandLineOptions(fromNSString(prefix), o)) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(NSArray*) parseIceCommandLineOptions:(NSArray*)options
{
    NSException* nsex = nil;
    try
    {
        std::vector<std::string> o;
        fromNSArray(options, o);
        return [toNSArray(properties_->parseIceCommandLineOptions(o)) autorelease];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}
-(void) load:(NSString*)file
{
    NSException* nsex = nil;
    try
    {
        properties_->load(fromNSString(file));
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    if(nsex != nil)
    {
        @throw nsex;
    }
}
-(id<ICEProperties>) clone
{
    NSException* nsex = nil;
    try
    {
        return [ICEProperties wrapperWithCxxObject:properties_->clone().get()];
    }
    catch(const std::exception& ex)
    {
        nsex = toObjCException(ex);
    }
    @throw nsex;
    return nil; // Keep the compiler happy.
}

@end

namespace
{

class UpdateCallbackI : public Ice::PropertiesAdminUpdateCallback
{
public:

    UpdateCallbackI(id<ICEPropertiesAdminUpdateCallback> callback) :
        _callback(callback)
    {
        [(ICEPropertiesAdminUpdateCallback*)callback setPropertiesAdminUpdateCallback:this];
    }

    void
    updated(const Ice::PropertyDict& properties)
    {
        [_callback updated:[toNSDictionary(properties) autorelease]];
    }

private:

    id<ICEPropertiesAdminUpdateCallback> _callback;
};

}

#define PROPERTIESADMINUPDATECALLBACK \
                    dynamic_cast<Ice::PropertiesAdminUpdateCallback*>(static_cast<IceUtil::Shared*>(cxxObject_))

@implementation ICEPropertiesAdminUpdateCallback
-(void) dealloc
{
    if(PROPERTIESADMINUPDATECALLBACK)
    {
        PROPERTIESADMINUPDATECALLBACK->__decRef();
    }
    [super dealloc];
}

-(void) setPropertiesAdminUpdateCallback:(Ice::PropertiesAdminUpdateCallback*)cxxObject
{
    assert(!PROPERTIESADMINUPDATECALLBACK);
    cxxObject_ = static_cast<IceUtil::Shared*>(cxxObject);
    PROPERTIESADMINUPDATECALLBACK->__incRef();
}

-(Ice::PropertiesAdminUpdateCallback*) propertiesAdminUpdateCallback
{
    return PROPERTIESADMINUPDATECALLBACK;
}
@end

#define NATIVEPROPERTIESADMIN dynamic_cast<Ice::NativePropertiesAdmin*>(static_cast<IceUtil::Shared*>(cxxObject_))

@implementation ICENativePropertiesAdmin
-(void) addUpdateCallback:(id<ICEPropertiesAdminUpdateCallback>)callback
{
    NSAssert([callback isKindOfClass:[ICEPropertiesAdminUpdateCallback class]], 
             @"callback not extends ICEPropertiesAdminUpdateCallback class");
    if([(ICEPropertiesAdminUpdateCallback*)callback propertiesAdminUpdateCallback])
    {
        NATIVEPROPERTIESADMIN->addUpdateCallback(
                                        [(ICEPropertiesAdminUpdateCallback*)callback propertiesAdminUpdateCallback]);
    }
    else
    {
        NATIVEPROPERTIESADMIN->addUpdateCallback(new UpdateCallbackI(callback));
    }
}

-(void) removeUpdateCallback:(id<ICEPropertiesAdminUpdateCallback>)callback
{
    NSAssert([callback isKindOfClass:[ICEPropertiesAdminUpdateCallback class]], 
             @"callback not extends ICEPropertiesAdminUpdateCallback class");

    NATIVEPROPERTIESADMIN->removeUpdateCallback(
                                        [(ICEPropertiesAdminUpdateCallback*)callback propertiesAdminUpdateCallback]);
}
@end
