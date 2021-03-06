// **********************************************************************
//
// Copyright (c) 2003-2014 ZeroC, Inc. All rights reserved.
//
// This copy of Ice is licensed to you under the terms described in the
// ICE_LICENSE file included in this distribution.
//
// **********************************************************************

#pragma once

module Test
{

sequence<byte> ByteSeq;

interface Timeout
{
    void op();
    void sendData(ByteSeq seq);
    void sleep(int to);

    void holdAdapter(int to);

    void shutdown();
};

};
